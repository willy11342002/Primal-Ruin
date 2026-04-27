extends TileMapLayer


@export var water_layer: TileMapLayer
@export var base_layers: Array[TileMapLayer]
@export var obstacle_layers: Array[TileMapLayer]


func build(_executor: Node, data: Resource) -> bool:
	if not data:
		return false

	var mouse_pos := get_global_mouse_position()
	var coords := local_to_map(mouse_pos)
	if not _check_can_build(coords, data):
		return false

	for layer in get_tree().get_nodes_in_group("TileMapLayer"):
		if layer.name == data.layer_name:
			_build_terrain(layer, coords, data)
	return false


func _check_can_build(coords: Vector2i, data: TerrainBuildingResource) -> bool:
	if data.water_need_empty != TerrainBuildingResource.LayerCheckType.IGNORED:
		if water_layer.get_cell_source_id(coords) != -1:
			if data.water_need_empty == TerrainBuildingResource.LayerCheckType.NEED_EMPTY:
				return false
		else:
			if data.water_need_empty == TerrainBuildingResource.LayerCheckType.NEED_NOT_EMPTY:
				return false
	
	if data.base_need_empty != TerrainBuildingResource.LayerCheckType.IGNORED:
		for layer in base_layers:
			if layer.get_cell_source_id(coords) != -1:
				if data.base_need_empty == TerrainBuildingResource.LayerCheckType.NEED_EMPTY:
					return false
				if data.base_need_empty == TerrainBuildingResource.LayerCheckType.NEED_NOT_EMPTY:
					break
	
	if data.obstacle_need_empty != TerrainBuildingResource.LayerCheckType.IGNORED:
		for layer in obstacle_layers:
			if layer.get_cell_source_id(coords) != -1:
				if data.obstacle_need_empty == TerrainBuildingResource.LayerCheckType.NEED_EMPTY:
					return false
				if data.obstacle_need_empty == TerrainBuildingResource.LayerCheckType.NEED_NOT_EMPTY:
					break

	return true


func _build_terrain(layer: TileMapLayer, coords: Vector2i, data: TerrainBuildingResource) -> bool:
	if layer.get_cell_source_id(coords) != -1:
		return false

	if data.terrain_type == 0:
		layer.set_cells_terrain_connect_with_signal(
			[coords],
			data.tarrain_source_id,
			data.tarrent_id
		)
		return true
	if data.terrain_type == 1:
		layer.set_cells_terrain_path_with_signal(
			[coords],
			data.tarrain_source_id,
			data.tarrent_id
		)
		return true

	return false
