class_name SkillContext
extends RefCounted

## 施法者
var caster: CombatUnit
## 當前處理的格子座標
var target_cell: Vector2i
## 該格子上的單位 (如果有的話)
var target_unit: CombatUnit
## 當前技能
var skill_data: SkillData

var raw_damage: float = 0.0      # 基礎傷害總和
var damage_multiplier: float = 1.0 # 總傷害倍率
var final_damage: int = 0        # 最終計算結果

var buffs_to_apply: Array[String] = [] # 預計附加的 Buff 列表
var terrain_to_change: String = ""      # 預計修改的地形類型
var should_summon: bool = false         # 是否觸發召喚
var summon_data: UnitData


func _init(_caster, _cell):
	caster = _caster
	target_cell = _cell
	target_unit = CombatServer.map_pos_to_unit(_cell)
