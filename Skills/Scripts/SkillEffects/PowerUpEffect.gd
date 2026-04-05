class_name PowerUpEffect
extends SkillEffect


@export var value: float = 0.2


func execute(context: SkillContext) -> void:
	context.damage_multiplier += value
