class_name MoveComponent
extends Node


signal input_direction_changed(new_direction: Vector2)
signal moving_state_changed(is_moving: bool)

@onready var entity: CharacterBody2D = get_parent()
@export var speed: float = 300.0 # 2D 的速度通常數值較大

var last_input_direction: Vector2 = Vector2.DOWN
var moving_threshold: float = 0.1


func _physics_process(_delta: float) -> void:
	if not entity: return
	# 這裡不再主動計算方向，只負責 move_and_slide 和基礎摩擦力
	if entity.velocity == Vector2.ZERO:
		return
		
	entity.move_and_slide()
	# 模擬簡單摩擦力，讓停止更自然
	entity.velocity = entity.velocity.move_toward(Vector2.ZERO, speed * 0.2)


func move(direction: Vector2) -> void:
	if not entity: return
	
	# 1. 發出訊號以更新動畫
	if direction != Vector2.ZERO and direction != last_input_direction:
		last_input_direction = direction
		input_direction_changed.emit(last_input_direction)

	# 2. 計算移動
	if direction != Vector2.ZERO:
		entity.velocity = direction * speed

	# 3. 發出移動狀態變化訊號
	var moving: bool = entity.velocity.length() > moving_threshold
	moving_state_changed.emit(moving)
