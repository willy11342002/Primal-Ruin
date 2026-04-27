extends Node


@export var enabled: bool = true
@export var move_component: MoveComponent
@export var action_component: ActionComponent


func _physics_process(_delta: float) -> void:
	if not enabled: return
	if not move_component: return

	var input_direction: Vector2 = Input.get_vector("MoveLeft", "MoveRight", "MoveForward", "MoveBackward")
	move_component.move(input_direction)


func _input(event: InputEvent) -> void:
	if not enabled: return
	if event.is_action_pressed("Confirm", false):
		print(action_component.slot.item.action)
		if not action_component.use_tool():
			print("interact")
			action_component.interact()

	if not OS.is_debug_build():
		return

	if event is InputEventKey and event.is_pressed() and event.keycode == Key.KEY_B:
		get_tree().call_group("ActionReceiver", "watering", null)
		get_tree().call_group("ActionReceiver", "_on_check_during_across_days")
