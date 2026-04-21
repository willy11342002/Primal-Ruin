extends StaticBody2D


@export var base_layers: Array[TileMapLayer] # 建議順序：由低到高
@export var physics_layer_index: int = 0


func _ready() -> void:
	generate_raw_physics_top_down()


func generate_raw_physics_top_down() -> void:
	# 0. 清理舊節點
	for child in get_children():
		child.queue_free()

	# 紀錄已被高層地塊佔用的座標
	var occupied_coords := {}

	# 2. 反向遍歷：從最後一層（最高層）開始處理
	var layers_count = base_layers.size()
	for i in range(layers_count - 1, -1, -1):
		var layer = base_layers[i]
		
		# 獲取該層所有使用的格子
		for coords in layer.get_used_cells():			
			# 高層地塊優先權 (核心修正)
			# 只要更高層在該座標有地塊，低層就直接跳過判斷
			if occupied_coords.has(coords):
				continue
			
			# 檢查該位置是否存在地塊
			var source_id = layer.get_cell_source_id(coords)
			if source_id != -1:
				# 只要有地塊存在，就標記此座標被高層佔用
				occupied_coords[coords] = true
				
				# 接下來才判斷這個地塊有沒有物理形狀
				var data: TileData = layer.get_cell_tile_data(coords)
				if not data: continue
				
				var poly_count = data.get_collision_polygons_count(physics_layer_index)
				for j in range(poly_count):
					var points = data.get_collision_polygon_points(physics_layer_index, j)
					_create_collision_child(layer, coords, points)


func _create_collision_child(layer: TileMapLayer, coords: Vector2i, points: PackedVector2Array) -> void:
	var col := CollisionPolygon2D.new()
	
	# 將 Tile 局部座標轉換為 Map 局部座標 (Map Space) [cite: 1]
	var map_pos = layer.map_to_local(coords)
	var transformed_points = PackedVector2Array()
	for p in points:
		transformed_points.append(p + map_pos)
	
	col.polygon = transformed_points
	col.set_meta("coords", coords)
	add_child(col)


func update_coords(coords: Vector2i) -> void:
	# 刪除該 coords 對應的舊碰撞 child
	for child in get_children():
		if child.has_meta("coords") and child.get_meta("coords") == coords:
			child.queue_free()

	# 從最高層往低層找，高層優先，找到有地塊的層就生成並停止
	var layers_count = base_layers.size()
	for i in range(layers_count - 1, -1, -1):
		var layer = base_layers[i]
		var source_id = layer.get_cell_source_id(coords)
		if source_id != -1:
			var data: TileData = layer.get_cell_tile_data(coords)
			if data:
				var poly_count = data.get_collision_polygons_count(physics_layer_index)
				for j in range(poly_count):
					var points = data.get_collision_polygon_points(physics_layer_index, j)
					_create_collision_child(layer, coords, points)
			break  # 高層優先，找到後不繼續往下層
