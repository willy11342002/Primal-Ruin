extends State


var skill: SkillData
var castable_positions: Array

var vfx_scene: PackedScene


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

	var map_pos = NavServer.local_to_map(CombatServer.current_unit.global_position)
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
		var target_position = camera.cast_position
		var caster_position = NavServer.local_to_map(CombatServer.current_unit.global_position)
		var impact_positions: Array = skill.get_impact_positions(caster_position, target_position)
		if impact_positions.size() > 0:
			# 支付代價
			skill.costs_pay(CombatServer.current_unit)
			# 計算技能效果
			var context = SkillContext.new()
			context.setup(CombatServer.current_unit, skill)
			# 展示施放特效
			await context.apply_cast_vfx(caster_position)
			# 每一個影響位置展示特效, 並處理效果
			for layer in impact_positions:
				for pos in layer:
					await context.resolve_cell(pos)

	if event.is_action_pressed("Cancel"):
		CombatServer.cancel_skill()


func _on_cast_position_changed(map_pos) -> void:
	NavServer.remove_preview_by_camp(Global.Camp.ENEMY)
	if skill == null: return
	if map_pos not in castable_positions: return

	var unit_map_pos = NavServer.local_to_map(CombatServer.current_unit.global_position)

	var preview_impact_positions: Array = []
	var impact_positions: Array = skill.get_impact_positions(unit_map_pos, map_pos)
	for layer in impact_positions:
		for pos in layer:
			if pos not in preview_impact_positions:
				preview_impact_positions.append(pos)
	
	NavServer.show_array(Global.Camp.ENEMY, preview_impact_positions, 0.01)
