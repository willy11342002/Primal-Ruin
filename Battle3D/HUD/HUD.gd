extends CanvasLayer


func _ready() -> void:
	CombatServer.after_end_turn.connect(_on_after_end_turn)
	CombatServer.before_end_turn.connect(_on_before_end_turn)


func _on_before_end_turn() -> void:
	if CombatServer.current_unit.update_requested.is_connected(_on_current_unit_update_requested):
		CombatServer.current_unit.update_requested.disconnect(_on_current_unit_update_requested)


func _on_after_end_turn() -> void:
	if CombatServer.current_unit == null:
		return
	
	CombatServer.current_unit.update_requested.connect(_on_current_unit_update_requested)
	_on_current_unit_update_requested()
	if CombatServer.current_unit.unit_data.camp == Global.Camp.PLAYER:
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
