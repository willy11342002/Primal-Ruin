class_name DamageEffect
extends SkillEffect


@export var value: float = 10.0


func apply(context: SkillContext) -> void:
	context.raw_damage += value
