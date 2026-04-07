class_name SkillContext
extends RefCounted

## 施法者
var caster: CombatUnit
## 當前技能
var skill: SkillData

## 技能消耗
var costs: Dictionary[String, int] = {}

## 基礎傷害總和
var raw_damage: float = 0.0
## 總傷害倍率
var damage_multiplier: float = 1.0
## 最終傷害結果，經過所有計算後的數值
var final_damage: int = 0

## 預計附加的 Buff 列表
var buffs_to_apply: Array[String] = []

## 預計召喚的單位資料列表
var summons: Array[UnitData] = []


func setup(_caster, _skill):
	caster = _caster
	skill = _skill

	for fragment in skill.fragments:
		# if fragment.cast_vfx:
		# 	fragment.cast_vfx.apply(self)

		# if fragment.impact_vfx:
		# 	fragment.impact_vfx.apply(self)

		for effect in fragment.effects:
			effect.apply(self)


func resolve_cell(cell: Vector2i) -> void:
	await apply_impact_vfx(cell)
	
	var target_unit: CombatUnit = CombatServer.map_pos_to_unit(cell)
	# 處理傷害
	if target_unit and raw_damage > 0:
		final_damage = int(raw_damage * damage_multiplier)
		target_unit.take_damage(final_damage)
	
	# 處理召喚
	if summons.size() > 0 and CombatServer.map_pos_to_unit(cell) == null:
		var summon_data = summons.pop_front()
		CombatServer.add_unit(summon_data, cell)


func apply_cast_vfx(cell: Vector2i) -> void:
	var world_pos = NavServer.map_to_local(cell)
	for fragment in skill.fragments:
		if fragment.cast_vfx:
			await fragment.cast_vfx.apply(world_pos)



func apply_impact_vfx(cell: Vector2i) -> void:
	var world_pos = NavServer.map_to_local(cell)
	for fragment in skill.fragments:
		if fragment.impact_vfx:
			await fragment.impact_vfx.apply(world_pos)
