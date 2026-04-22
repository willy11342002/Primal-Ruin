extends Node


@export var nav_agent: NavigationAgent2D
@export var move_component: MoveComponent

var _is_active := false


func _ready() -> void:
	if nav_agent:
		nav_agent.velocity_computed.connect(_on_velocity_computed)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Cancel", true):
		nav_agent.target_position = get_parent().get_global_mouse_position()
		_is_active = true
	elif event.is_action_released("Cancel"):
		_is_active = false


func _process(_delta: float) -> void:
	if _is_active:
		nav_agent.target_position = get_parent().get_global_mouse_position()


func _on_velocity_computed(safe_velocity: Vector2) -> void:
	move_component.move(safe_velocity)


func _physics_process(_delta: float) -> void:
	if not move_component: return
	
	if nav_agent.is_navigation_finished():
		move_component.move(Vector2.ZERO)
		return

	var next_pos = nav_agent.get_next_path_position()
	var current_pos = get_parent().global_position
	var dir = current_pos.direction_to(next_pos)
	var target_velocity = dir
	
	if nav_agent.avoidance_enabled:
		nav_agent.set_velocity(target_velocity)
	else:
		_on_velocity_computed(target_velocity)
