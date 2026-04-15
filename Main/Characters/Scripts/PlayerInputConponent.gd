extends Node
class_name InputComponent


var input_horizontal := Vector2.ZERO


func _process(_delta: float) -> void:
	input_horizontal = Input.get_vector("MoveLeft", "MoveRight", "MoveForward", "MoveBackward")


func get_movement_direction() -> Vector3:
	return Vector3(input_horizontal.x, 0, input_horizontal.y).normalized()
