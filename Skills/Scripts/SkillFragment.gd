class_name SkillFragment
extends Resource


@export var cast_vfx: SkillVFX
@export var impact_vfx: SkillVFX

## 碎片效果, 由效果最小單位組成
@export var effects: Array[SkillEffect]

## 技能消耗, 由碎片提供
@export var cost: SkillCost

## 影響範圍, 定義是否擴散影響其他格子
@export var impact_rule: ImpactRule

