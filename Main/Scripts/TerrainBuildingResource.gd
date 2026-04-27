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

@export var water_need_empty: LayerCheckType = LayerCheckType.IGNORED
@export var base_need_empty: LayerCheckType = LayerCheckType.IGNORED
@export var obstacle_need_empty: LayerCheckType = LayerCheckType.IGNORED
