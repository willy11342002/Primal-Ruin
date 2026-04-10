class_name FragmentBody
extends RigidBody2D


@export var shape: CollisionShape2D
@onready var shield_mat: ShaderMaterial = $ShieldRimSprite.material
## 像素/秒
@export var speed := 220.0
## 轉向平滑度，越大越快轉向
@export var turn_smooth := 8.0
## 每隔幾秒換一次方向
@export var change_interval := 0.8

var data: SkillFragment
var is_hovered: bool = false
var is_dragging: bool = false
var max_radius: float = 200.0
var _dir := Vector2.RIGHT
var _time_left := 0.0

signal drag_started(data: SkillFragment)
signal hovered(data: SkillFragment)
signal unhovered


func setup(_data: SkillFragment) -> void:
	data = _data
	$IconSprite.texture = data.icon
	shape.shape.radius = data.radius

	# 根據 Resource 半徑調整視覺
	var visual_scale = (data.radius * 2.0) / 128.0
	$ShieldRimSprite.scale = Vector2.ONE * visual_scale


	shield_mat.set_shader_parameter("line_color", Color(0.953, 0.537, 1.0))
	shield_mat.set_shader_parameter("actual_contacts", 5)
	shield_mat.set_shader_parameter("hit_points", [0.0, 0.0, 0.0, 0.0, 0.0])
	shield_mat.set_shader_parameter("hit_intensities", [0.0, 0.0, 0.0, 0.0, 0.0])

	_pick_new_dir()
	_time_left = change_interval


func _pick_new_dir() -> void:
	_dir = Vector2.RIGHT.rotated(randf_range(-PI, PI)).normalized()


func _on_area_2d_mouse_entered() -> void:
	is_hovered = true
	hovered.emit(data)


func _on_area_2d_mouse_exited() -> void:
	is_hovered = false
	unhovered.emit()


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			is_dragging = true


func _input(event: InputEvent) -> void:
	if is_dragging and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			is_dragging = false


func _on_exit_container() -> void:
	await get_tree().process_frame
	drag_started.emit(data)
	queue_free()


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var dt := state.step

	if is_dragging:
		state.transform.origin = get_global_mouse_position()
		state.linear_velocity = Vector2.ZERO
		return

	_time_left -= dt
	if _time_left <= 0.0:
		_pick_new_dir()
		_time_left = change_interval

	# 目標速度
	var target_v := _dir * speed

	# 平滑轉向到目標速度（不會瞬間跳）
	var t : float = clamp(turn_smooth * dt, 0.0, 1.0)
	state.linear_velocity = state.linear_velocity.lerp(target_v, t)

	
	var center_pos = get_parent().global_position
	_apply_boundary_limit(state, center_pos, state.transform.origin - center_pos)


func _apply_boundary_limit(state: PhysicsDirectBodyState2D, center_pos: Vector2, relative_pos: Vector2) -> void:
	var dist = relative_pos.length()
	if dist > max_radius - shape.shape.radius:
		# 撞到邊界時，強行修正位置並反轉法線速度
		var normal = relative_pos.normalized()
		var corrected_pos = center_pos + (normal * (max_radius - shape.shape.radius))
		state.transform.origin = corrected_pos

		# 緩衝：如果還在往外衝，就把徑向速度消掉
		var current_vel = state.linear_velocity
		if current_vel.dot(normal) > 0:
			state.linear_velocity = current_vel - normal * current_vel.dot(normal)
