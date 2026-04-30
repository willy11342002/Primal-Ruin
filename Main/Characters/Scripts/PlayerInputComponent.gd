extends Node


@export var enabled: bool = true
@export var nav_component: Node
@export var move_component: MoveComponent
@export var action_component: ActionComponent
@onready var entity: CharacterBody2D = get_parent()

var _input_direction: Vector2 = Vector2.ZERO


func _physics_process(_delta: float) -> void:
	if not enabled: return
	if not move_component: return
	move_component.move(_input_direction)
	if _input_direction != Vector2.ZERO:
		nav_component.stop()


func _unhandled_input(event: InputEvent) -> void:
	if not enabled: return
	
	_input_direction = Input.get_vector("MoveLeft", "MoveRight", "MoveForward", "MoveBackward")
	
	if event.is_action_pressed("Confirm", false):
		action_component.use_tool()
	if event.is_action_pressed("Cancel", false):
		action_component.interact()
	if event.is_action_pressed("RotateBuildingRight", false):
		action_component.rotate_building_right()
	if event.is_action_pressed("RotateBuildingLeft", false):
		action_component.rotate_building_left()

	if not OS.is_debug_build():
		return

	if event.is_action_pressed("DebugWindow"):
		Persistence.toggle_debug_window()
	if event.is_action_pressed("DebugDayPass"):
		get_tree().call_group("ActionReceiver", "watering", entity, entity.get_global_mouse_position(), null)
		get_tree().call_group("ActionReceiver", "_on_check_during_across_days")
