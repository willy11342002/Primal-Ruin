class_name SkillFragment
extends Resource


@export var name: String
@export var icon: Texture2D


@export var cast_vfx: SkillVFX
@export var impact_vfx: SkillVFX

## 碎片半徑, 用於合成UI時的範圍顯示
@export var radius: float = 1.0

## 碎片效果, 由效果最小單位組成
@export var effects: Array[SkillEffect]

## 技能消耗, 由碎片提供
@export var cost: SkillCost

## 施法範圍, 定義可施放法術的格子
@export var cast_rule: CastRule

## 影響範圍, 定義是否擴散影響其他格子
@export var impact_rule: ImpactRule
