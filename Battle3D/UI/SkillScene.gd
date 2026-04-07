extends TextureButton


var unit: CombatUnit
var skill: SkillData


func setup(_unit: CombatUnit, _skill: SkillData) -> void:
	unit = _unit
	skill = _skill
	%SkillIcon.texture = skill.icon
	unit.update_requested.connect(_on_unit_update)
	CombatServer.canceled_skill.connect(_on_canceled_skill)
	_on_unit_update()


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		CombatServer.choose_skill(skill)


func _on_unit_update() -> void:
	var can_afford = skill.costs_enough(unit)

	disabled = not can_afford
	if disabled and button_pressed:
		button_pressed = false
		CombatServer.cancel_skill()


func _on_canceled_skill() -> void:
	button_pressed = false
