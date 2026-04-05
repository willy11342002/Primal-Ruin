class_name DamageEffect
extends SkillEffect


@export var value: float = 10.0


func execute(context: SkillContext) -> void:
	context.raw_damage += value
