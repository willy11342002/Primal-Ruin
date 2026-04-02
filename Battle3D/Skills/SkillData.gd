class_name SkillData
extends Resource


@export var name: String
@export var icon: Texture2D
@export var description: String

## 技能消耗
@export var cost: SkillCost

## 施放邏輯, 用來決定可被施放格子
@export var cast_rule: CastRule
## 波及邏輯, 用來決定造成效果的格子
@export var impact_rule: ImpactRule
## 能量傳遞, 用來決定如何通過路徑
@export var emitter_rule: EmitterRule


func costs_enough(unit: CombatUnit) -> bool:
	var property_name: String = SkillCost.Type.keys()[cost.type].to_lower()
	var property = unit.unit_data.get(property_name)
	if property == null:
		return false
	if property < cost.amount:
		return false
	return true


func costs_pay(unit: CombatUnit) -> void:
	var property_name: String = SkillCost.Type.keys()[cost.type].to_lower()
	var property = unit.unit_data.get(property_name)
	if property == null:
		return
	unit.unit_data.set_property(property_name, property - cost.amount)
