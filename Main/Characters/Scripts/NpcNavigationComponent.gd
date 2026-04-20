extends Node


@export var nav_agent: NavigationAgent2D
@export var rotation_speed: float = 10.0

var _move_direction := Vector2.ZERO
var _is_active := false


func _ready() -> void:
	if not nav_agent:
		push_error("NpcNavigationComponent: 找不到 NavigationAgent2D")
		return
	
	nav_agent.path_desired_distance = 4.0
	nav_agent.target_desired_distance = 4.0


func _process(delta: float) -> void:
	if not _is_active or nav_agent.is_navigation_finished():
		_move_direction = Vector2.ZERO
		return

	# 1. 獲取下一個路徑點
	var next_path_position: Vector2 = nav_agent.get_next_path_position()
	var current_position: Vector2 = get_parent().global_position
	
	# 2. 計算方向
	_move_direction = (next_path_position - current_position).normalized()

	# 3. 處理轉向 (2D 旋轉通常是旋轉 rotation 屬性)
	_handle_rotation(delta)


func _handle_rotation(delta: float) -> void:
	if _move_direction.length() > 0.01:
		var parent = get_parent() as Node2D
		if parent:
			# 計算目標角度
			var target_rotation = _move_direction.angle()
			# 平滑旋轉
			parent.rotation = lerp_angle(parent.rotation, target_rotation, rotation_speed * delta)


func get_movement_direction() -> Vector2:
	return _move_direction


func move_to(target_pos: Vector2) -> void:
	nav_agent.target_position = target_pos
	_is_active = true


func stop() -> void:
	_is_active = false
	_move_direction = Vector2.ZERO
