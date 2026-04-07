extends RigidBody2D


@export var drag_speed: float = 20.0
@export var max_radius: float = 200.0
@export var radius: float = 16.0
var is_dragging: bool = false
@export var self_gravity: float = 3.0
## 拖動的力道
@export var drag_force: float = 20.0
@export var prevent_boundary_limit: bool = true

func _ready() -> void:
	$CollisionShape2D.shape.radius = radius


func _on_input_event(_viewport, event, _shape_idx):
	# 當玩家按下左鍵點擊碎片
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = event.pressed


func _input(event: InputEvent) -> void:
	if is_dragging and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			is_dragging = false


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var center_pos = get_parent().global_position
	var relative_pos = state.transform.origin - center_pos
	
	# 處理拖動 (虛擬彈簧感)
	if is_dragging:
		var mouse_pos = get_global_mouse_position()
		# 計算指向滑鼠的向量
		var target_dir = global_position.direction_to(mouse_pos)
		var dist = global_position.distance_to(mouse_pos)
		# 施加一個向滑鼠拉的力 (力道隨距離增加)
		state.apply_central_force(target_dir * dist * drag_force)

	else:
		# 處理中心引力
		var gravity_dir = -relative_pos.normalized()
		state.apply_central_force(gravity_dir * self_gravity * relative_pos.length())

	# 處理邊界限制 (防止飛出去)
	if prevent_boundary_limit:
		_apply_boundary_limit(state, center_pos, relative_pos)


func _apply_boundary_limit(state: PhysicsDirectBodyState2D, center_pos: Vector2, relative_pos: Vector2) -> void:
	var dist = relative_pos.length()
	if dist > max_radius - radius:
		# 撞到邊界時，強行修正位置並反轉法線速度
		var normal = relative_pos.normalized()
		var corrected_pos = center_pos + (normal * (max_radius - radius))
		state.transform.origin = corrected_pos

		# 緩衝：如果還在往外衝，就把徑向速度消掉
		var current_vel = state.linear_velocity
		if current_vel.dot(normal) > 0:
			state.linear_velocity = current_vel - normal * current_vel.dot(normal)
