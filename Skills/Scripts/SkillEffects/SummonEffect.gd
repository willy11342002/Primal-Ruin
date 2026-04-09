class_name SummonEffect
extends SkillEffect


@export var unit_data: UnitData


func apply(context: SkillContext) -> void:
	context.summons.append(unit_data)


func description() -> String:
	var result = tr("p_Summon")
	result += unit_data.name
	return result
