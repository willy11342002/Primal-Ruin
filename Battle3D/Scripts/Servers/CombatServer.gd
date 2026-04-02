extends Node


signal hover_unit_changed(new_unit)
signal setup_finished
signal before_end_turn
signal after_end_turn

@export var unit_scene: PackedScene

var combat_data: CombatData
var current_unit: CombatUnit: get = get_current_unit
var hovered_unit: CombatUnit = null
var distances: Dictionary = {}
var move_path: Array = []

## 當前選擇的單位
var toggled_unit: CombatUnit = null
## 當前選擇的技能
var toggled_skill: SkillData = null


func setup(_data: CombatData) -> void:
	combat_data = _data
	after_end_turn.emit()
	setup_finished.emit()
	choose_unit(null)


func end_turn() -> void:
	NavServer.clear_preview()
	before_end_turn.emit()
	current_unit.unit_data.end_turn()
	if not current_unit.unit_data.depleted:
		after_end_turn.emit()
		choose_unit(null)
	else:
		await get_tree().create_timer(0.5).timeout
		end_turn()


func hover_on_unit(unit: CombatUnit) -> void:
	if unit:
		unit.hover_on()
	hovered_unit = unit
	hover_unit_changed.emit(unit.unit_data.camp)


func hover_off_unit(unit: CombatUnit) -> void:
	if hovered_unit == unit:
		if unit:
			unit.hover_off()
		hovered_unit = null
		hover_unit_changed.emit(null)


func map_pos_to_unit(map_pos: Variant) -> CombatUnit:
	for unit in get_tree().get_nodes_in_group("CombatUnit"):
		if unit is CombatUnit:
			var unit_map_pos = NavServer.world_to_map(unit.global_position)
			if unit_map_pos == map_pos:
				return unit
	return


func get_current_unit() -> CombatUnit:
	combat_data.units.sort_custom(func(a, b):
		return a.next_time < b.next_time
	)
	return combat_data.units[0].unit


func get_move_range(unit: CombatUnit) -> Dictionary:
	var map_pos = NavServer.world_to_map(unit.global_position)
	distances = NavServer.find_range(
		map_pos,
		unit.unit_data.balance_movement,
		unit.unit_data.move_skill.pass_func,
		unit.unit_data.move_skill.exclude_func
	)
	return distances


func clear_units() -> void:
	for child in get_children():
		child.queue_free()


func add_unit(_data: UnitData, pos: Vector2i) -> CombatUnit:
	var unit: CombatUnit = unit_scene.instantiate()
	add_child(unit)
	unit.global_position = NavServer.map_to_world(pos)
	unit.setup(_data)
	return unit


func move_unit_alone_path(unit: CombatUnit, path: Array) -> void:
	var cost = distances.get(path[-1], INF)
	Global.pause_player_input.emit(true)
	await unit.move_alone_path(path)
	unit.unit_data.balance_movement -= cost
	Global.pause_player_input.emit(false)
	choose_unit(null)


## 選擇單位
## 如果選擇非當前單位, 預覽該單位行動格
## 選擇無效單位或當前單位, 預覽該單位行動格以及移動路徑
func choose_unit(unit: CombatUnit) -> void:
	NavServer.clear_preview()
	if unit == null or unit == current_unit:
		toggled_unit = null
		get_move_range(current_unit)
		NavServer.show_range(current_unit.unit_data.camp, distances)
	else:
		toggled_unit = unit
		get_move_range(toggled_unit)
		NavServer.show_range(toggled_unit.unit_data.camp, distances)


## 未選擇其他單位時, 選擇格子用以預覽移動
func get_path_pos(map_pos: Variant) -> Array:
	if toggled_unit != null:
		return []

	get_move_range(current_unit)
	return NavServer.find_path_from_range(distances, map_pos)


func show_path(path: Array) -> void:
	NavServer.show_path(path)


func choose_skill(skill: SkillData) -> void:
	toggled_skill = skill
	if toggled_skill == null:
		choose_unit(null)
		return
	else:
		NavServer.clear_preview()
		if toggled_unit == null:
			get_move_range(current_unit)
			NavServer.show_range(current_unit.unit_data.camp, distances)
		else:
			get_move_range(toggled_unit)
			NavServer.show_range(toggled_unit.unit_data.camp, distances)


func preview_skill(_target_pos: Variant) -> void:
	if toggled_skill == null: return


func cast_skill(_target_pos: Variant) -> void:
	if toggled_skill == null: return

	toggled_skill.costs_pay(current_unit)
	print('嘗試釋放技能: ', toggled_skill.name, ' 目標位置: ', _target_pos)
	print(current_unit.unit_data.ap)
