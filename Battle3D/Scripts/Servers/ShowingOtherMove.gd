extends State


var unit: CombatUnit


func enter(context: Dictionary = {}) -> void:
	if not context.has("unit"):
		return
	unit = context['unit']
	var map_pos = NavServer.world_to_map(unit.global_position)
	var distances = NavServer.find_range(
		map_pos,
		unit.unit_data.balance_movement,
		unit.unit_data.move_skill.pass_func,
		unit.unit_data.move_skill.exclude_func
	)
	NavServer.show_range(unit.unit_data.camp, distances)

func exit() -> void:
	unit = null
	NavServer.clear_preview()


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("Cancel"):
		translate_to("IdleState")
