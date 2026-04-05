class_name ForkRule
extends ImpactRule


func get_valid_positions(direction: Vector2i) -> Array:
	if direction == Vector2i.ZERO: return []

	var d = direction.sign()
	var forward = Vector2(d)
	var left_45 = forward.rotated(deg_to_rad(-45)).round()
	var right_45 = forward.rotated(deg_to_rad(45)).round()
	
	return [
		d,
		Vector2i(left_45.x, left_45.y),
		Vector2i(right_45.x, right_45.y)
	]
