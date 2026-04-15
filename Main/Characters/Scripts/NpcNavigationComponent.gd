extends Node

## 引用必要的節點
@export var nav_agent: NavigationAgent3D
@export var rotation_speed: float = 10.0 # 轉向速度

## 內部狀態
var _move_direction := Vector3.ZERO
var _is_active := false


func _ready() -> void:
	# 確保導航 Agent 配置正確
	if not nav_agent:
		push_error("NPCNavigationComponent: 找不到 NavigationAgent3D 節點")
		return
	
	# 設定導航參數（可依需求調整）
	nav_agent.path_desired_distance = 0.5
	nav_agent.target_desired_distance = 0.5


func _process(delta: float) -> void:
	if not _is_active or nav_agent.is_navigation_finished():
		_move_direction = Vector3.ZERO
		return

	# 1. 獲取導航路徑中的下一個點
	var next_path_position: Vector3 = nav_agent.get_next_path_position()
	var current_position: Vector3 = get_parent().global_position
	
	# 2. 計算移動方向
	var new_dir = (next_path_position - current_position).normalized()
	_move_direction = Vector3(new_dir.x, 0, new_dir.z) # 鎖定 Y 軸，防止 NPC 想往地底鑽

	# 3. 處理轉向功能
	_handle_rotation(delta)


## 平滑轉向邏輯
func _handle_rotation(delta: float) -> void:
	if _move_direction.length() > 0.01:
		var parent = get_parent() as Node3D
		if parent:
			# 計算目標旋轉（看向移動方向）
			var target_basis = Basis.looking_at(_move_direction)
			# 使用 slerp 進行平滑旋轉插值
			parent.basis = parent.basis.slerp(target_basis, rotation_speed * delta)
			# 重置 X 與 Z 軸旋轉，確保 NPC 不會因為慣性傾斜
			parent.rotation.x = 0
			parent.rotation.z = 0


## 接口：獲取移動向量 (與原本 InputComponent 介面一致)
func get_movement_direction() -> Vector3:
	return _move_direction


## 接口：指派目標位置
func move_to(target_pos: Vector3) -> void:
	nav_agent.target_position = target_pos
	_is_active = true


## 接口：停止移動
func stop() -> void:
	_is_active = false
	_move_direction = Vector3.ZERO