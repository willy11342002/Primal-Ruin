extends PanelContainer


var unit: CombatUnit


func setup(data: UnitData) -> void:
	%Head.texture = data.head
	%HealthBar.max_value = data.max_health
	%HealthBar.value = data.health
	unit = data.unit
	unit.update_requested.connect(_on_update_requested)
	_on_after_end_turn()


func _ready() -> void:
	CombatServer.after_end_turn.connect(_on_after_end_turn)


func _on_after_end_turn() -> void:
	var is_this_unit := CombatServer.current_unit == unit
	var tween := create_tween()
	if is_this_unit:
		tween.tween_property(self, "scale", Vector2.ONE, 0.2)
	else:
		tween.tween_property(self, "scale", 0.8 * Vector2.ONE, 0.2)


func _on_update_requested() -> void:
	%HealthBar.max_value = unit.unit_data.max_health
	%HealthBar.value = unit.unit_data.health


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		get_tree().get_first_node_in_group("Controller").set_target(unit)
