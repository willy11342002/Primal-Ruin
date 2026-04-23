extends TileMapLayer


## 指定要填入的 Tile ID 與 Atlas 座標 (通常是一個全填滿導航多邊形的方塊)
@export var placeholder_source_id: int = 0
@export var placeholder_atlas_coords: Vector2i = Vector2i(0, 0)

var base_layers: Array[TileMapLayer] = []


func update_coords(coords: Vector2i) -> void:
	# 刪除原格子
	erase_cell(coords)

	# 更新導航
	for layer in base_layers:
		var data: TileData = layer.get_cell_tile_data(coords)
		if not data:
			continue

		# 檢查上方格子是否有影響此格
		var above_coords = Vector2i(coords.x, coords.y - 1)
		var above_data: TileData = layer.get_cell_tile_data(above_coords)
		if above_data:
			var above_under = above_data.get_custom_data("alternative_under")
			if above_under not in [null, -1]:
				set_cell(coords, placeholder_source_id, placeholder_atlas_coords, above_under)
				return

		# 更新本格，有值的話就不再檢查其他層
		var alt = data.get_custom_data("alternative_tile")
		if alt != -1:
			set_cell(coords, placeholder_source_id, placeholder_atlas_coords, alt)
			return
