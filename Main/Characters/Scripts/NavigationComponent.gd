extends Node


@onready var entity: CharacterBody2D = get_parent()
@export var nav_agent: NavigationAgent2D
@export var move_component: MoveComponent

var is_auto_moving: bool = false

signal navigation_finished
signal navigation_interrupted


func _ready() -> void:
	if not nav_agent:
		push_error("NpcNavigationComponent: 找不到 NavigationAgent2D")
		return

	nav_agent.velocity_computed.connect(_on_velocity_computed)


func move_to(target_pos: Vector2) -> void:
	if nav_agent:
		nav_agent.target_position = target_pos
		is_auto_moving = true


func stop() -> void:
	if is_auto_moving:
		if nav_agent:
			nav_agent.target_position = entity.global_position
		is_auto_moving = false
		navigation_interrupted.emit()


func _physics_process(_delta: float) -> void:
	if not move_component: return
	if not nav_agent: return
	
	if nav_agent.is_navigation_finished():
		navigation_finished.emit()
		move_component.move(Vector2.ZERO)
		is_auto_moving = false
		return

	var next_pos = nav_agent.get_next_path_position()
	var current_pos = get_parent().global_position
	var dir = current_pos.direction_to(next_pos)
	var target_velocity = dir
	
	if nav_agent.avoidance_enabled:
		nav_agent.set_velocity(target_velocity)
	else:
		_on_velocity_computed(target_velocity)


func _on_velocity_computed(safe_velocity: Vector2) -> void:
	move_component.move(safe_velocity)
