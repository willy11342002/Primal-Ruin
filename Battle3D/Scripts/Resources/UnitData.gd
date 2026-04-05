class_name UnitData
extends Resource


@export var head: Texture2D
@export var camp: Global.Camp
@export var turn: int = 0
@export var ap: int = 1
@export var balance_movement: float = 0.0
@export var next_time: float = 0.0
@export var depleted: bool = false

@export_group("Animation")
@export var sprite_size: float = 1.0
@export var back_animation: SpriteFrames
@export var front_animation: SpriteFrames

@export_group("Stats")
@export var max_health: int
@export var health: int = -1: set = set_health
@export var max_mana: int
@export var mana: int = -1: set = set_mana
@export var speed: int
@export var strength: int
@export var agility: int
@export var intelligence: int

@export_group("Skills")
@export var move_skill: MoveSkillData
@export var skills: Array[SkillData]

var unit: CombatUnit


func set_health(v):
	var initing: int = health == -1

	health = clampi(v, 0, max_health)
	if unit:
		unit.call_deferred("emit_signal", "update_requested")
	if not initing and health == 0:
		depleted = true
		if unit != null:
			await unit.play_animation("Deplete")
			CombatServer.end_turn()


func set_mana(v):
	mana = clampi(v, 0, max_mana)
	if unit:
		unit.call_deferred("emit_signal", "update_requested")


func _init() -> void:
	next_time = randf()
	if unit != null:
		unit.call_deferred("emit_signal", "update_requested")


func set_property(property, _value) -> void:
	if property not in self: return

	set(property, _value)
	if unit != null:
		unit.call_deferred("emit_signal", "update_requested")


func get_controller() -> String:
	var _controller: String = "Player"
	if camp != Global.Camp.PLAYER:
		_controller = "AI"
	return _controller


func end_turn() -> void:
	next_time += 120.0 / speed
	balance_movement = speed
	ap = 1
	turn += 1
