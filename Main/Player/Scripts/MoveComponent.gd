extends Node
class_name MoveComponent

@onready var entity: CharacterBody3D = get_parent()
@export var input_handler: InputComponent


func _physics_process(delta: float) -> void:
	if not entity: return
	
	# 1. 處理重力
	if not entity.is_on_floor():
		entity.velocity.y -= entity.gravity * delta

	# 2. 獲取輸入方向
	var direction = input_handler.get_movement_direction()
	
	# 3. 計算水平移動
	if direction:
		entity.velocity.x = direction.x * entity.speed
		entity.velocity.z = direction.z * entity.speed
	else:
		# 簡易摩擦力/減速
		entity.velocity.x = move_toward(entity.velocity.x, 0, entity.speed)
		entity.velocity.z = move_toward(entity.velocity.z, 0, entity.speed)

	# 4. 處理跳躍 (範例)
	#if Input.is_action_just_pressed("ui_accept") and entity.is_on_floor():
		#entity.velocity.y = entity.jump_velocity
