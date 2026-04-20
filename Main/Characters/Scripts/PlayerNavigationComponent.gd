extends Node


@export var nav_agent: NavigationAgent2D
@export var move_component: MoveComponent
@export var rotation_speed: float = 10.0

var _is_active := false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			nav_agent.target_position = get_parent().get_global_mouse_position()
			_is_active = true 


func _physics_process(_delta: float) -> void:
	if not move_component or not _is_active: return
	
	if nav_agent.is_navigation_finished():
		move_component.move(Vector2.ZERO)
		_is_active = false
		return

	# 1. 獲取導航方向 
	var next_pos = nav_agent.get_next_path_position()
	var dir = (next_pos - get_parent().global_position).normalized()
	
	# 2. 推動移動組件
	move_component.move(dir)
