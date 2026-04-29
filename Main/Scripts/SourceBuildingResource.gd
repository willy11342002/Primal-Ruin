class_name SourceBuildingResource
extends Resource


@export var layer_name: String
@export var source_id: int
@export var atlas_coords: Vector2i
@export var alternalive_id: int = 0

@export var water_need_empty: BuildingManager.LayerCheckType
@export var base_need_empty: BuildingManager.LayerCheckType
@export var obstacle_need_empty: BuildingManager.LayerCheckType


func check_can_build(coords, water_layer, base_layers, obstacle_layers) -> bool:
	if water_need_empty != BuildingManager.LayerCheckType.IGNORED:
		if water_layer.get_cell_source_id(coords) != -1:
			if water_need_empty == BuildingManager.LayerCheckType.NEED_EMPTY:
				return false
		else:
			if water_need_empty == BuildingManager.LayerCheckType.NEED_NOT_EMPTY:
				return false
	
	if base_need_empty != BuildingManager.LayerCheckType.IGNORED:
		for layer in base_layers:
			if layer.get_cell_source_id(coords) != -1:
				if base_need_empty == BuildingManager.LayerCheckType.NEED_EMPTY:
					return false
				if base_need_empty == BuildingManager.LayerCheckType.NEED_NOT_EMPTY:
					break
	
	if obstacle_need_empty != BuildingManager.LayerCheckType.IGNORED:
		for layer in obstacle_layers:
			if layer.get_cell_source_id(coords) != -1:
				if obstacle_need_empty == BuildingManager.LayerCheckType.NEED_EMPTY:
					return false
				if obstacle_need_empty == BuildingManager.LayerCheckType.NEED_NOT_EMPTY:
					break
	
	return true


func build(layers: Array, coords: Vector2i) -> void:
	for layer in layers:
		if layer.name == layer_name:
			layer.set_cell_with_signal(coords, source_id, atlas_coords, alternalive_id)
			return
