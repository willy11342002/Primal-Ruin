extends CanvasLayer


@export var sort_scene: PackedScene
@export var skill_scene: PackedScene

var button_group: ButtonGroup


func _ready() -> void:
	button_group = ButtonGroup.new()
	CombatServer.after_end_turn.connect(_on_after_end_turn)
	CombatServer.before_end_turn.connect(_on_before_end_turn)
	CombatServer.setup_finished.connect(_on_setup_finished)


func _on_before_end_turn() -> void:
	if CombatServer.current_unit.update_requested.is_connected(_on_current_unit_update_requested):
		CombatServer.current_unit.update_requested.disconnect(_on_current_unit_update_requested)


func _on_setup_finished() -> void:
	# 生成回合順序UI
	for child in %SortDisplay.get_children():
		child.queue_free()
	for unit: UnitData in CombatServer.combat_data.units:
		var order = sort_scene.instantiate()
		order.setup(unit)
		%SortDisplay.add_child(order)


func _on_after_end_turn() -> void:
	if CombatServer.current_unit == null:
		return

	# 綁定當前角色在左下角顯示
	CombatServer.current_unit.update_requested.connect(_on_current_unit_update_requested)
	_on_current_unit_update_requested()

	# 生成技能UI
	for child in %SkillDisplay.get_children():
		child.queue_free()
	for skill in CombatServer.current_unit.unit_data.skills:
		var skill_ui = skill_scene.instantiate()
		skill_ui.setup(CombatServer.current_unit, skill)
		skill_ui.button_group = button_group
		%SkillDisplay.add_child(skill_ui)

	# 根據當前角色是否可控 顯示/隱藏 玩家UI
	if CombatServer.current_unit.unit_data.get_controller() == 'Player':
		get_tree().call_group("PlayerControl", "show")
	else:
		get_tree().call_group("PlayerControl", "hide")


func _on_current_unit_update_requested() -> void:
	%Head.texture = CombatServer.current_unit.unit_data.head
	%HealthBar.max_value = CombatServer.current_unit.unit_data.max_health
	%HealthBar.value = CombatServer.current_unit.unit_data.health
	%ManaBar.max_value = CombatServer.current_unit.unit_data.max_mana
	%ManaBar.value = CombatServer.current_unit.unit_data.mana


func _on_end_turn_button_up() -> void:
	CombatServer.end_turn()


func _on_head_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		get_tree().get_first_node_in_group("Controller").set_target(CombatServer.current_unit)
