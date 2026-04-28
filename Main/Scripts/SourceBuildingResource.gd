class_name SourceBuildingResource
extends Resource


@export var layer_name: String
@export var source_id: int
@export var atlas_coords: Vector2i
@export var alternalive_id: int = 0

@export var water_need_empty: BuildingManager.LayerCheckType
@export var base_need_empty: BuildingManager.LayerCheckType
@export var obstacle_need_empty: BuildingManager.LayerCheckType


func build(layer: TileMapLayer, coords: Vector2i) -> void:
	layer.set_cell_source_id_with_signal(coords, source_id)
