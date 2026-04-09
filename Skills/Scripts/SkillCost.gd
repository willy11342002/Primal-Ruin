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


var property_name: String: get = get_property_name


func get_property_name() -> String:
	return Type.keys()[type].to_lower()


func apply(costs: Dictionary) -> void:
	if costs.has(property_name):
		costs[property_name] += amount
	else:
		costs[property_name] = amount


func description() -> String:
	return tr("p_Increase") + tr("p_Cost") + tr("p_" + property_name) + ": " + str(amount)
