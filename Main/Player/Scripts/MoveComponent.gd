extends Node
class_name MoveComponent


signal input_direction_changed(new_direction: Vector3)

@onready var entity: CharacterBody3D = get_parent()
@export var input_handler: InputComponent
@export var speed := 5.0
@export var jump_velocity := 4.5

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var last_input_direction: Vector3 = Vector3.FORWARD


func _physics_process(delta: float) -> void:
	if not entity: return
	
	# 1. 處理重力
	if not entity.is_on_floor():
		entity.velocity.y -= gravity * delta

	# 2. 獲取輸入方向
	var direction = input_handler.get_movement_direction()
	
	# 3. 計算水平移動
	if direction != Vector3.ZERO and direction != last_input_direction:
		last_input_direction = direction
		input_direction_changed.emit(last_input_direction)

	if direction:
		entity.velocity.x = direction.x * speed
		entity.velocity.z = direction.z * speed
	else:
		# 簡易摩擦力/減速
		entity.velocity.x = move_toward(entity.velocity.x, 0, speed)
		entity.velocity.z = move_toward(entity.velocity.z, 0, speed)

	# 4. 處理跳躍 (範例)
	#if Input.is_action_just_pressed("ui_accept") and entity.is_on_floor():
		#entity.velocity.y = jump_velocity
