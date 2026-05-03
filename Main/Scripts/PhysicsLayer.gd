extends TileMapLayer


@export var placeholder_source_id: int = 0
@export var placeholder_atlas_coords: Vector2i = Vector2i(0, 0)

@export var base_layers: Array[TileMapLayer] = []


func update_coords(coords: Vector2i) -> void:
	erase_cell(coords)

	for layer in base_layers:
		# 檢查上方格子是否有影響此格
		var above_data: TileData = layer.get_cell_tile_data(coords + Vector2i.UP)
		if above_data:
			var above_under = above_data.get_custom_data("alternative_under")
			if above_under not in [null, -1]:
				set_cell(coords, placeholder_source_id, placeholder_atlas_coords + Vector2i(above_under, 0))
				print("under: ", coords, layer.name)
				return

		# 更新本格，有值的話就不再檢查其他層
		var data: TileData = layer.get_cell_tile_data(coords)
		if data:
			var alt = data.get_custom_data("alternative_tile")
			if alt != -1:
				set_cell(coords, placeholder_source_id, placeholder_atlas_coords + Vector2i(alt, 0))
				print("normal: ", coords, layer.name)
				return
