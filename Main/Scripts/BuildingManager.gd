extends TileMapLayer
class_name BuildingManager


enum LayerCheckType {
	IGNORED,
	NEED_EMPTY,
	NEED_NOT_EMPTY
}


@export var water_layer: TileMapLayer
@export var base_layers: Array[TileMapLayer]
@export var obstacle_layers: Array[TileMapLayer]

var _preview_data: Resource = null
var _preview_coords := Vector2i(-9999, -9999)


func preview_building(data: Resource) -> void:
	clear()
	_preview_data = null
	_preview_coords = Vector2i(-9999, -9999)

	var building := _resolve(data)
	if not building:
		visible = false
		return

	for layer in get_tree().get_nodes_in_group("TileMapLayer"):
		if layer.name == building.layer_name:
			tile_set = layer.tile_set
			break

	_preview_data = data
	visible = true


func _process(_delta: float) -> void:
	if not _preview_data:
		return

	var building := _resolve(_preview_data)
	if not building:
		return

	var coords := local_to_map(to_local(get_global_mouse_position()))
	if coords == _preview_coords:
		return

	clear()
	_preview_coords = coords

	if building is SourceBuildingResource:
		set_cell(coords, building.source_id, building.atlas_coords, building.alternalive_id)
	elif building is TerrainBuildingResource:
		set_cells_terrain_connect([coords], building.tarrain_source_id, building.tarrent_id)


func _resolve(data: Resource) -> Resource:
	if data is DirectionBuildingResource:
		return data.buildings[data.index] if data.buildings.size() > 0 else null
	if data is SourceBuildingResource or data is TerrainBuildingResource:
		return data
	return null


func build(_executor: Node, target_position: Vector2, data: Resource) -> bool:
	if not data:
		return false

	var coords := local_to_map(target_position)
	if not data.check_can_build(coords, water_layer, base_layers, obstacle_layers):
		return false

	data.build(get_tree().get_nodes_in_group("TileMapLayer"), coords)
	return false
