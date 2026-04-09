class_name DamageEffect
extends SkillEffect


@export var value: float = 10.0


func apply(context: SkillContext) -> void:
	context.base_damage += value


func description() -> String:
	var result = tr("p_BaseDamage")
	if value > 0:
		result += tr("p_Increase")
	else:
		result += tr("p_Decrease")
	result += str(value)

	return result
