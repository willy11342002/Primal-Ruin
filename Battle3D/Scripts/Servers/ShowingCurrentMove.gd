extends State


var path: Array
var distances: Dictionary

var camera: PlayerController:
	get:
		return get_tree().get_first_node_in_group("Controller")


func enter(_context: Dictionary = {}) -> void:
	var map_pos = NavServer.world_to_map(CombatServer.current_unit.global_position)
	distances = NavServer.find_range(
		map_pos,
		CombatServer.current_unit.unit_data.balance_movement,
		CombatServer.current_unit.unit_data.move_skill.pass_func,
		CombatServer.current_unit.unit_data.move_skill.exclude_func
	)
	NavServer.show_range(CombatServer.current_unit.unit_data.camp, distances)
	if camera:
		camera.cast_position_changed.connect(_on_cast_position_changed)


func exit() -> void:
	path.clear()
	distances.clear()
	NavServer.clear_preview()
	if camera and camera.cast_position_changed.is_connected(_on_cast_position_changed):
		camera.cast_position_changed.disconnect(_on_cast_position_changed)


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("Confirm"):
		if path.size() > 0:
			CombatServer.move_unit_alone_path(
				CombatServer.current_unit,
				path.duplicate(),
				distances.get(path[-1], INF)
			)

	if event.is_action_pressed("Cancel"):
		translate_to("IdleState")


func _on_cast_position_changed(map_pos) -> void:
	path = NavServer.find_path_from_range(distances, map_pos)
	if path.size() > 0:
		NavServer.show_path(path)
