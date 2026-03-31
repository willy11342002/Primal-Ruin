class_name AIController
extends Node3D


var paused: bool = false


func _ready() -> void:
	CombatServer.after_end_turn.connect(_on_after_end_turn)


func _on_after_end_turn() -> void:
	if CombatServer.current_unit == null:
		return

	paused = CombatServer.current_unit.unit_data.get_controller() == "Player"
	if not paused:
		take_turn()


func take_turn() -> void:
	# 這裡可以實現 AI 的行為邏輯，例如移動、攻擊等。
	# 目前只是簡單地等待一段時間後結束回合。
	await get_tree().create_timer(1.0).timeout
	CombatServer.end_turn()
