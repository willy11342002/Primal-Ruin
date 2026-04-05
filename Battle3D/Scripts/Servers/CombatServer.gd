extends Machine


signal setup_finished
signal before_end_turn
signal after_end_turn
signal canceled_skill

@export var unit_scene: PackedScene

var combat_data: CombatData
var current_unit: CombatUnit: get = get_current_unit
var skill_castable_positions: Array = []
var distances: Dictionary = {}
var move_path: Array = []




func setup(_data: CombatData) -> void:
	combat_data = _data
	after_end_turn.emit()
	setup_finished.emit()
	mode = true
	_init_states()


func end_turn() -> void:
	NavServer.clear_preview()
	before_end_turn.emit()
	current_unit.unit_data.end_turn()
	if not current_unit.unit_data.depleted:
		after_end_turn.emit()
		translate_to("IdleState")
	else:
		await get_tree().create_timer(0.5).timeout
		end_turn()


func map_pos_to_unit(map_pos: Variant) -> CombatUnit:
	for unit in get_tree().get_nodes_in_group("CombatUnit"):
		if unit is CombatUnit:
			var unit_map_pos = NavServer.local_to_map(unit.global_position)
			if unit_map_pos == map_pos:
				return unit
	return


func get_current_unit() -> CombatUnit:
	combat_data.units.sort_custom(func(a, b):
		return a.next_time < b.next_time
	)
	return combat_data.units[0].unit


func clear_units() -> void:
	for child in get_children():
		if child is State:
			continue
		child.queue_free()


func add_unit(_data: UnitData, pos: Vector2i) -> CombatUnit:
	var unit: CombatUnit = unit_scene.instantiate()
	add_child(unit)
	unit.global_position = NavServer.map_to_local(pos)
	unit.setup(_data)
	return unit


func move_unit_alone_path(unit: CombatUnit, path: Array, cost: float) -> void:
	translate_to("IdleState")
	Global.pause_player_input.emit(true)
	await unit.move_alone_path(path)
	unit.unit_data.balance_movement -= cost
	Global.pause_player_input.emit(false)


## 取消技能
func cancel_skill() -> void:
	translate_to("IdleState")
	canceled_skill.emit()


## 選擇技能, 預覽技能可釋放的位置
func choose_skill(skill: SkillData) -> void:
	translate_to("ShowingSkill", {"skill": skill})
