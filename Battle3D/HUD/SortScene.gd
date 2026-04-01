extends PanelContainer


func setup(data: UnitData) -> void:
	%Head.texture = data.head
	%HealthBar.max_value = data.max_health
	%HealthBar.value = data.health
	data.unit.update_requested.connect(_on_update_requested)


func _on_update_requested() -> void:
	%HealthBar.max_value = CombatServer.current_unit.unit_data.max_health
	%HealthBar.value = CombatServer.current_unit.unit_data.health
