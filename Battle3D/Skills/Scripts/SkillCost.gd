class_name SkillCost
extends Resource


enum Type {
	AP,
	MANA,
	HEALTH,
	SPEED,
	BALANCE_MOVEMENT,
	STRENGTH,
	AGILITY,
	INTELLIGENCE
}


@export var type: Type
@export var amount: int
