class_name LongitudeImpact
extends ImpactRule


func get_valid_positions(direction: Vector2i) -> Array:
	if direction == Vector2i.ZERO: return []
	return [direction]


func description() -> String:
	var result = tr("p_AfterImpact") + " " + tr("p_LongitudeImpact")
	return result
