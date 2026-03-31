extends Node3D


@onready var sprite: AnimatedSprite3D = $Sprite3D


func _physics_process(_delta: float) -> void:
	if CombatServer.current_unit == null:
		hide()
		return

	sprite.modulate = Global.CampColor[CombatServer.current_unit.unit_data.camp]
	global_position = CombatServer.current_unit.global_position
	show()
