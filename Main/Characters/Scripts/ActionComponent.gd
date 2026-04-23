class_name ActionComponent
extends Node2D


@export var radius: float = 50.0
@export var action: String = "interact"
@export var data: Resource


func click() -> void:
	var mouse_pos := get_global_mouse_position()
	var distance = global_position.distance_to(mouse_pos)
	if distance > radius:
		return

	get_tree().call_group("ActionReceiver", action, data)
