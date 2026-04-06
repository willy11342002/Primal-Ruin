class_name PowerUpEffect
extends SkillEffect


@export var value: float = 0.2


func apply(context: SkillContext) -> void:
	context.damage_multiplier += value
