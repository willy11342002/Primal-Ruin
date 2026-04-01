class_name RangeImpactRule
extends ImpactRule


@export var radius: int = 3


func get_valid_positions(_direction: Vector2i) -> Array:
	var range_distance = NavServer.find_range(
		Vector2i.ZERO,
		radius,
	)
	return range_distance.keys()
