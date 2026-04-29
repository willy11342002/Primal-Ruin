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


func build(_executor: Node, target_position: Vector2, data: Resource) -> bool:
	if not data:
		return false

	var coords := local_to_map(target_position)
	if not data.check_can_build(coords, water_layer, base_layers, obstacle_layers):
		return false

	data.build(get_tree().get_nodes_in_group("TileMapLayer"), coords)
	return false


# func _check_can_build(coords: Vector2i, data: Resource) -> bool:
# 	if data.water_need_empty != LayerCheckType.IGNORED:
# 		if water_layer.get_cell_source_id(coords) != -1:
# 			if data.water_need_empty == LayerCheckType.NEED_EMPTY:
# 				return false
# 		else:
# 			if data.water_need_empty == LayerCheckType.NEED_NOT_EMPTY:
# 				return false
	
# 	if data.base_need_empty != LayerCheckType.IGNORED:
# 		for layer in base_layers:
# 			if layer.get_cell_source_id(coords) != -1:
# 				if data.base_need_empty == LayerCheckType.NEED_EMPTY:
# 					return false
# 				if data.base_need_empty == LayerCheckType.NEED_NOT_EMPTY:
# 					break
	
# 	if data.obstacle_need_empty != LayerCheckType.IGNORED:
# 		for layer in obstacle_layers:
# 			if layer.get_cell_source_id(coords) != -1:
# 				if data.obstacle_need_empty == LayerCheckType.NEED_EMPTY:
# 					return false
# 				if data.obstacle_need_empty == LayerCheckType.NEED_NOT_EMPTY:
# 					break

# 	return true
