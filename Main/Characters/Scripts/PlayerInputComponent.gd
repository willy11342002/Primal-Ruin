extends Node


@export var move_component: MoveComponent
@export var action_component: ActionComponent


func _physics_process(_delta: float) -> void:
	if not move_component: return

	var input_direction: Vector2 = Input.get_vector("MoveLeft", "MoveRight", "MoveForward", "MoveBackward")
	move_component.move(input_direction)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Confirm", false):
		action_component.click()
