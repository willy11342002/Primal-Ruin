extends StaticBody2D


@export var physics_layer_index: int = 0

var base_layers: Array[TileMapLayer] = []


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
	for layer in base_layers:
		var source_id = layer.get_cell_source_id(coords)
		if source_id != -1:
			var data: TileData = layer.get_cell_tile_data(coords)
			if data:
				var poly_count = data.get_collision_polygons_count(physics_layer_index)
				for j in range(poly_count):
					var points = data.get_collision_polygon_points(physics_layer_index, j)
					_create_collision_child(layer, coords, points)
			break  # 高層優先，找到後不繼續往下層
