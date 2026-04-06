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


func apply(costs: Dictionary) -> void:
	var property_name: String = Type.keys()[type].to_lower()

	if costs.has(property_name):
		costs[property_name] += amount
	else:
		costs[property_name] = amount
