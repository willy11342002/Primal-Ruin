extends Node


@export var nav_agent: NavigationAgent2D
@export var move_component: MoveComponent

var _is_active := false


func _input(event: InputEvent) -> void:
	if "pressed" in event:
		_is_active = event.pressed

	if event.is_action_pressed("Confirm", true):
		nav_agent.target_position = get_parent().get_global_mouse_position()


func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and _is_active:
		nav_agent.target_position = get_parent().get_global_mouse_position()


func _physics_process(_delta: float) -> void:
	if not move_component: return
	
	if nav_agent.is_navigation_finished():
		move_component.move(Vector2.ZERO)
		return

	# 1. 獲取導航方向 
	var next_pos = nav_agent.get_next_path_position()
	var dir = (next_pos - get_parent().global_position).normalized()
	
	# 2. 推動移動組件
	move_component.move(dir)
