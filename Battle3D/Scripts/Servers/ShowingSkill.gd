extends State


var skill: SkillData
var castable_positions: Array
var impact_positions: Array

var camera: PlayerController:
	get:
		return get_tree().get_first_node_in_group("Controller")


func enter(context: Dictionary = {}) -> void:
	if not context.has("skill"):
		push_error("NoSkill In ShowingSkill State")
		translate_to("Empty")
		return
	skill = context["skill"]
	NavServer.clear_preview()

	var map_pos = NavServer.world_to_map(CombatServer.current_unit.global_position)
	castable_positions = skill.get_castable_positions(map_pos)
	NavServer.show_array(Global.Camp.NEUTRAL, castable_positions)
	if camera:
		camera.cast_position_changed.connect(_on_cast_position_changed)


func exit() -> void:
	skill = null
	castable_positions.clear()
	NavServer.clear_preview()
	if camera and camera.cast_position_changed.is_connected(_on_cast_position_changed):
		camera.cast_position_changed.disconnect(_on_cast_position_changed)


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("Confirm"):
		if impact_positions.size() > 0:
			skill.costs_pay(CombatServer.current_unit)
	if event.is_action_pressed("Cancel"):
		CombatServer.cancel_skill()


func _on_cast_position_changed(map_pos) -> void:
	NavServer.remove_preview_by_camp(Global.Camp.ENEMY)
	impact_positions.clear()
	if skill == null: return
	if map_pos not in castable_positions: return

	var unit_map_pos = NavServer.world_to_map(CombatServer.current_unit.global_position)
	impact_positions = skill.get_impact_positions(unit_map_pos, map_pos)
	
	NavServer.show_array(Global.Camp.ENEMY, impact_positions, 0.01)
