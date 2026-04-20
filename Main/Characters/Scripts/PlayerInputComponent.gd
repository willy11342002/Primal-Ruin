extends Node


@export var move_component: MoveComponent


func _physics_process(_delta: float) -> void:
	if not move_component: return

	var input_direction: Vector2 = Input.get_vector("MoveLeft", "MoveRight", "MoveForward", "MoveBackward")
	move_component.move(input_direction)
