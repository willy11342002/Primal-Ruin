extends State


var camera: PlayerController:
	get:
		return get_tree().get_first_node_in_group("Controller")


func handle_input(event: InputEvent) -> void:
	if not camera:
		push_error("Camera not found")
		return

	if event.is_action_pressed("Confirm"):
		var unit: CombatUnit = CombatServer.map_pos_to_unit(camera.cast_position)
		if not unit:
			return
		if unit == CombatServer.current_unit:
			translate_to("ShowingCurrentMove")
		else:
			translate_to("ShowingOtherMove", {"unit": unit})
