class_name SummonEffect
extends SkillEffect


@export var unit_data: UnitData


func execute(context: SkillContext) -> void:
	context.summon_data = unit_data
