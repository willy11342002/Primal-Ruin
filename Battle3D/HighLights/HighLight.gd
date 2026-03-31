extends Node3D


@onready var sprite: AnimatedSprite3D = $Sprite3D
var target: CombatUnit


func _ready() -> void:
	CombatServer.after_end_turn.connect(_on_after_end_turn)


func _on_after_end_turn() -> void:
	target = CombatServer.current_unit


func _physics_process(_delta: float) -> void:
	if target == null:
		hide()
		return

	sprite.modulate = Global.CampColor[target.unit_data.camp]
	global_position = target.global_position
	show()
