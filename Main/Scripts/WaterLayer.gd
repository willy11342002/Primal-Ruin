extends TileMapLayer


## 引用的地面層
@export var base_layers: Array[TileMapLayer] = []
## 擴張範圍
@export var expand_margin: int = 3

## 地形集索引
@export var water_terrain_set: int = 0
## 「水」地形在該集合中的 ID
@export var water_terrain_id: int = 0


func _ready() -> void:
	if base_layers.is_empty():
		push_error("base_layers 尚未設定！請至少指定一個 TileMapLayer 作為基礎參考。")
		return

	clear()
	generate_water_layer()


func _get_merged_rect() -> Rect2i:
	var merged_rect: Rect2i = Rect2i()
	for layer in base_layers:
		merged_rect = merged_rect.merge(layer.get_used_rect())
	return merged_rect


func _expand_rect(rect: Rect2i, margin: int) -> Rect2i:
	var new_position = rect.position - Vector2i(margin, margin)
	var new_size = rect.size + Vector2i(margin * 2, margin * 2)
	return Rect2i(new_position, new_size)


func _has_tile_on_layers(coords: Vector2i) -> bool:
	for layer in base_layers:
		if layer.get_cell_source_id(coords) != -1:
			return true
	return false


func generate_water_layer() -> void:
	# 1. 取得所有基礎圖層的合併範圍，並擴張一定的 margin
	var base_rect: Rect2i = _get_merged_rect()
	base_rect = _expand_rect(base_rect, expand_margin)
	print("擴張後的範圍：", base_rect)	

	var cells_to_paint_terrain = [] # 準備填入自動地形的座標清單

	# 2. 雙迴圈跑範圍
	for x in range(base_rect.position.x, base_rect.end.x):
		for y in range(base_rect.position.y, base_rect.end.y):
			var coords = Vector2i(x, y)
			
			# 檢查 Base Layer 在此座標是否有東西
			if _has_tile_on_layers(coords):
				continue
			cells_to_paint_terrain.append(coords)

	# 3. 執行填寫
	print("需要填入自動地形的座標數量：", cells_to_paint_terrain.size())
	if cells_to_paint_terrain.size() > 0:
		set_cells_terrain_connect(cells_to_paint_terrain, water_terrain_set, water_terrain_id)
