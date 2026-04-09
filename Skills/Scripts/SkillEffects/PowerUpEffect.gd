class_name PowerUpEffect
extends SkillEffect


@export var value: float = 0.2


func apply(context: SkillContext) -> void:
	context.damage_multiplier += value


func description() -> String:
	var result = tr("p_DamageMultiplier")
	if value > 0:
		result += tr("p_Increase")
	else:
		result += tr("p_Decrease")
	result += str(value)

	return result
