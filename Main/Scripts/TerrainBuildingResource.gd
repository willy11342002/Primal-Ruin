class_name TerrainBuildingResource
extends Resource


enum LayerCheckType {
	IGNORED,
	NEED_EMPTY,
	NEED_NOT_EMPTY
}

@export var layer_name: String
@export_enum("CONNECT", "PATH") var terrain_type: int
@export var tarrain_source_id: int
@export var tarrent_id: int

@export var water_need_empty: BuildingManager.LayerCheckType
@export var base_need_empty: BuildingManager.LayerCheckType
@export var obstacle_need_empty: BuildingManager.LayerCheckType


func build(layer: TileMapLayer, coords: Vector2i) -> void:
	if terrain_type == 0:
		layer.set_cells_terrain_connect_with_signal(
			[coords],
			tarrain_source_id,
			tarrent_id
		)
	else:
		layer.set_cells_terrain_path_with_signal(
			[coords],
			tarrain_source_id,
			tarrent_id
		)
