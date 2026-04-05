class_name LatitudeRule
extends ImpactRule


func get_valid_positions(direction: Vector2i) -> Array:
	if direction.x != 0:
		return [Vector2i.UP, Vector2i.DOWN]
	if direction.y != 0:
		return [Vector2i.LEFT, Vector2i.RIGHT]
	return []
