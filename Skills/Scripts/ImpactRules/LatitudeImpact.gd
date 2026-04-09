class_name LatitudeImpact
extends ImpactRule


func get_valid_positions(direction: Vector2i) -> Array:
	if direction.x != 0:
		return [Vector2i.UP, Vector2i.DOWN]
	if direction.y != 0:
		return [Vector2i.LEFT, Vector2i.RIGHT]
	return []


func description() -> String:
	var result = tr("p_AfterImpact") + " " + tr("p_LatitudeImpact")
	return result
