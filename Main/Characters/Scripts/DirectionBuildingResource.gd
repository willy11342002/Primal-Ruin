class_name DirectionBuildingResource
extends Resource


@export var buildings: Array[SourceBuildingResource]

var index: int = 0


func build(layer: TileMapLayer, coords: Vector2i) -> void:
	if buildings.size() == 0:
		return

	buildings[index].build(layer, coords)
