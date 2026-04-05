class_name FourWayRule
extends ImpactRule


func get_valid_positions(_direction: Vector2i) -> Array[Vector2i]:
	if _direction == Vector2i.ZERO: return []
	return [
		Vector2i.UP,    # (0, -1)
		Vector2i.DOWN,  # (0, 1)
		Vector2i.LEFT,  # (-1, 0)
		Vector2i.RIGHT  # (1, 0)
	]
