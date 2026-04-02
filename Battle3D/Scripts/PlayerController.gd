class_name PlayerController
extends Node3D


signal rotation_changed(_camera_forward: Vector3)
signal cast_position_changed(cast_position: Variant)

@onready var camera: Camera3D = $Camera3D

@export_group('Camera')
@export var rotation_speed: float = 120.0
@export_range(1,100) var min_zoom: float = 10
@export_range(1,100) var max_zoom: float = 100
@export var zoom_speed: float = 10
@export_range(0.1, 20.0) var follow_speed: float = 5.0
@export_range(0.1, 20.0) var move_speed: float = 5.0

var unit_info: Dictionary = {}
var zoom_direction: int = 0
var paused: bool = false
var target: Node3D: set = set_target
var cast_position: Variant = null


func set_target(unit: CombatUnit) -> void:
	target = unit


func _ready() -> void:
	Global.pause_player_input.connect(func(p): paused = p)
	CombatServer.after_end_turn.connect(_on_after_end_turn)


func _on_after_end_turn() -> void:
	if CombatServer.current_unit == null:
		return
	paused = CombatServer.current_unit.unit_data.get_controller() != "Player"
	target = CombatServer.current_unit


func _unhandled_input(event: InputEvent) -> void:
	if paused: return
	var map_pos = get_raycasted_position()

	# 滑鼠移動
	if event is InputEventMouseMotion:
		# 發送訊號, 更新滑鼠位置
		if cast_position != map_pos:
			cast_position = map_pos
			cast_position_changed.emit(map_pos)

		# 有選取技能時, 嘗試預覽技能範圍
		if CombatServer.toggled_skill:
			CombatServer.preview_skill(map_pos)
			return
		
		# 沒有選取單位, 嘗試預覽移動路徑
		if CombatServer.toggled_unit == null:
			var path = CombatServer.get_path_pos(map_pos)
			if path.size() > 0:
				CombatServer.show_path(path)

	# 滑鼠點擊
	if event.is_action_pressed("Confirm"):
		# 嘗試釋放技能
		if CombatServer.toggled_skill:
			CombatServer.cast_skill(map_pos)
			return
		# 沒有選取單位, 嘗試移動
		if CombatServer.toggled_unit == null:
			var path = CombatServer.get_path_pos(map_pos)
			if path.size() > 0:
				CombatServer.move_unit_alone_path(CombatServer.current_unit, path)
				return

		# 嘗試選取某個單位, 用於預覽其行動
		var unit: CombatUnit = CombatServer.map_pos_to_unit(map_pos)
		CombatServer.choose_unit(unit)

	if event.is_action_pressed("Cancel"):
		# 取消技能選取
		if CombatServer.toggled_skill:
			CombatServer.choose_skill(null)
		# 取消選取單位
		elif CombatServer.toggled_unit:
			CombatServer.choose_unit(null)

	# 相機縮放
	if event.is_action_pressed("CameraZoomIn"):
		zoom_direction = -1
	if event.is_action_pressed("CameraZoomOut"):
		zoom_direction = 1


func _process(delta: float) -> void:
	# 相機縮放
	if zoom_direction != 0:
		_zoom_camera(zoom_direction)

	# 相機旋轉
	var rot_dir := Input.get_axis("CameraRotateLeft", "CameraRotateRight")
	if rot_dir != 0:
		_rotate_camera(rot_dir, delta)

	# 相機跟隨
	if is_instance_valid(target):
		_follow_target(delta)
	elif target:
		target = null

	# 暫停狀態下不處理相機移動
	if paused: return

	# 相機移動
	var input_dir := Input.get_vector("CameraLeft", "CameraRight", "CameraForward", "CameraBackward")
	if input_dir != Vector2.ZERO:
		_move_camera(input_dir.normalized(), delta)
		target = null


func _follow_target(delta: float) -> void:
	var target_position := global_position
	target_position.x = target.global_position.x
	target_position.z = target.global_position.z
	global_position = global_position.move_toward(target_position, follow_speed * delta)
		

## 取得滑鼠目前對應的格子座標, 如果沒有射線碰撞到任何物件，或是碰撞點不在導航網格上，則回傳 null。
func get_raycasted_position() -> Variant:
	var mouse_pos = get_viewport().get_mouse_position()

	# 1. 定義射線的起點與終點
	var ray_from = camera.project_ray_origin(mouse_pos)
	var ray_to = ray_from + camera.project_ray_normal(mouse_pos) * 1000.0

	# 2. 執行射線檢測
	var space_state = camera.get_world_3d().get_direct_space_state()
	# 如果你的 TileMapLayer3D 在特定層級，可以設定 collision_mask
	var query = PhysicsRayQueryParameters3D.create(ray_from, ray_to)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)

	if not result:
		return null

	# 3. 取得碰撞點的像素座標
	var hit_position = result.position
	
	# 4. 轉換成網格座標
	var map_pos: Vector2i = NavServer.world_to_map(hit_position)
	
	return map_pos


## 相機縮放, direction: -1 為拉遠, 1 為拉近
func _zoom_camera(direction: int) -> void:
	if camera.projection == Camera3D.PROJECTION_PERSPECTIVE:
		var new_fov = camera.fov + direction * zoom_speed
		camera.fov = clamp(new_fov, min_zoom, max_zoom)
	elif camera.projection == Camera3D.PROJECTION_ORTHOGONAL:
		var new_size = camera.size + direction * zoom_speed
		camera.size = clamp(new_size, min_zoom, max_zoom)
	zoom_direction = 0


## 相機旋轉, direction: -1 為向左旋轉, 1 為向右旋轉
func _rotate_camera(direction: float, delta: float) -> void:
	rotation.y += direction * rotation_speed * delta
	rotation_changed.emit(-camera.global_basis.z)


## 相機移動
func _move_camera(direction: Vector2, delta: float) -> void:
	# 取得相機的前方與右方向量
	var forward = global_transform.basis.z
	var right = global_transform.basis.x

	# 抹除Y軸分量，確保相機在水平面上移動
	forward.y = 0
	right.y = 0
	forward = forward.normalized()
	right = right.normalized()

	# 計算移動向量
	var movement = (forward * direction.y + right * direction.x) * move_speed * delta

	# 應用移動
	global_position += movement

	# 限制相機在地圖邊界內
	var start: Vector3 = NavServer.grid_to_world(NavServer.map_to_grid(NavServer.base_level.rect.position, 0))
	var end: Vector3 = NavServer.grid_to_world(NavServer.map_to_grid(NavServer.base_level.rect.end, 0))
	global_position.x = clamp(global_position.x, start.x, end.x)
	global_position.z = clamp(global_position.z, start.z, end.z)
