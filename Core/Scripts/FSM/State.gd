class_name State extends Node


var state_machine: Machine
var target: Node


func _ready() -> void:
	await get_tree().physics_frame


func init() -> void:
	pass


func enter() -> void:
	pass


func exit() -> void:
	pass


func process_update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


func handle_input(_event: InputEvent) -> void:
	pass


func translate_to(new_state: String) -> void:
	state_machine.translate_to(new_state)
