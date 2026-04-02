class_name LineImpactRule
extends ImpactRule


@export var radius: int = 3


func get_valid_positions(direction: Vector2i) -> Array:
	var positions = []
	for i in range(radius):
		positions.append(direction * i)
	return positions
