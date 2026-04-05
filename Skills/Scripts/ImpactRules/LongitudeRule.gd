class_name LongitudeRule
extends ImpactRule


func get_valid_positions(direction: Vector2i) -> Array:
	if direction == Vector2i.ZERO: return []
	return [direction]
