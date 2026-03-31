extends CanvasLayer


func _ready() -> void:
	CombatServer.after_end_turn.connect(_on_after_end_turn)


func _on_after_end_turn() -> void:
	if CombatServer.current_unit == null:
		return
	
	if CombatServer.current_unit.unit_data.camp == Global.Camp.PLAYER:
		get_tree().call_group("PlayerControl", "show")
	else:
		get_tree().call_group("PlayerControl", "hide")


func _on_end_turn_button_up() -> void:
	CombatServer.end_turn()
