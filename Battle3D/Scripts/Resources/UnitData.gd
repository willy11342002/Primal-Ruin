class_name UnitData
extends Resource


@export var camp: Global.Camp
@export var turn: int = 0
@export var ap: int = 1
@export var balance_movement: float = 0.0
@export var next_time: float = 0.0

@export_group("Animation")
@export var idle_animation: SpriteFrames
@export var move_animation: SpriteFrames
@export var attack_animation: SpriteFrames
@export var die_animation: SpriteFrames

@export_group("Stats")
@export var max_health: int
@export var health: int = -1: set = set_health
@export var max_mana: int
@export var mana: int = -1: set = set_mana
@export var speed: int
@export var strength: int
@export var agility: int
@export var intelligence: int

@export var skills: Array[SkillData]

var unit: CombatUnit


func set_health(v):
	var initing: int = health == -1

	health = clampi(v, 0, max_health)
	if not initing and health == 0:
		if unit != null:
			unit.health_depleted.emit()
	

func set_mana(v):
	mana = clampi(v, 0, max_mana)


func _init() -> void:
	next_time = randf()
	if unit != null:
		unit.call_deferred("emit_signal", "update_requested")


func _set(property, _value) -> bool:
	if property not in self:
		return false

	if unit != null:
		unit.call_deferred("emit_signal", "update_requested")
	return false


func get_controller() -> String:
	var _controller: String = "Player"
	if camp != Global.Camp.PLAYER:
		_controller = "AI"
	return _controller + "TurnState"


func end_turn() -> void:
	next_time += 120.0 / speed
	balance_movement = speed
	ap = 1
	turn += 1
