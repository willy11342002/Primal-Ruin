class_name NormalMove
extends MoveSkillData


func pass_func(coords: Vector2i) -> bool:
	var unit = CombatServer.map_pos_to_unit(coords)
	if unit == null:
		return false
	if unit.unit_data.camp == CombatServer.current_unit.unit_data.camp:
		return false

	return true


func exclude_func(coords: Vector2i) -> bool:
	var unit = CombatServer.map_pos_to_unit(coords)
	if unit == CombatServer.current_unit:
		return false
	if unit == null:
		return false
	return true
