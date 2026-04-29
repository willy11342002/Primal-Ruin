class_name DirectionBuildingResource
extends Resource


@export var buildings: Array[SourceBuildingResource]

var index: int = 0:
	set(value):
		if buildings.size() == 0:
			index = 0
		else:
			index = value % buildings.size()



func rotate_right() -> void:
	index += 1


func rotate_left() -> void:
	index -= 1


func check_can_build(coords, water_layer, base_layers, obstacle_layers) -> bool:
	if buildings.size() == 0:
		return false

	return buildings[index].check_can_build(coords, water_layer, base_layers, obstacle_layers)


func build(layers: Array, coords: Vector2i) -> void:
	if buildings.size() == 0:
		return

	buildings[index].build(layers, coords)
