class_name SkillData
extends Resource


@export var name: String
@export var description: String

## 技能消耗
@export var cost: SkillCost

## 施放邏輯, 用來決定可被施放格子
@export var cast_rule: CastRule
## 波及邏輯, 用來決定造成效果的格子
@export var impact_rule: ImpactRule
## 能量傳遞, 用來決定如何通過路徑
@export var emitter_rule: EmitterRule
