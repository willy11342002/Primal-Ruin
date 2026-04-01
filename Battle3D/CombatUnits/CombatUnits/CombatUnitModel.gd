class_name CombatUnitModel
extends Node3D


# cos(72°) ≈ 0.309, cos(73°) ≈ 0.292
const SCALAR_THRESHOLD: float = 0.306
const FLIP_THRESHOLD: float = 0.0

@export var default_animation: String = "Idle"
@export var looping_animations: Array[String] = ["Idle", "Move"]

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var front_animation: AnimatedSprite3D = $Front
@onready var back_animation: AnimatedSprite3D = $Back

var unit: CombatUnit
var _camera_forward: Vector3 = Vector3.FORWARD


func _ready() -> void:
	set_notify_transform(true)

	var camera: PlayerController = get_tree().get_first_node_in_group("Controller")
	if camera:
		camera.rotation_changed.connect(_on_rotation_changed)
		camera.rotation_changed.emit(-camera.global_basis.z)
	
	unit = get_parent() as CombatUnit


func _notification(what: int) -> void:
	if what in [NOTIFICATION_TRANSFORM_CHANGED, NOTIFICATION_LOCAL_TRANSFORM_CHANGED]:
		_update_facing()


func _on_rotation_changed(camera_forward: Vector3) -> void:
	_camera_forward = camera_forward
	_update_facing()


func _update_facing() -> void:
	var horizontal_camera_forward := Vector3(_camera_forward.x, 0.0, _camera_forward.z)
	if horizontal_camera_forward.length_squared() == 0.0:
		return
	horizontal_camera_forward = horizontal_camera_forward.normalized()

	var yaw_basis := Basis.from_euler(Vector3(0.0, global_rotation.y, 0.0))
	var model_right := yaw_basis.x
	var model_back := yaw_basis.z


	# 面相左側時，flip_h = true, 面相右側時，flip_h = false。
	if model_right.dot(horizontal_camera_forward) > FLIP_THRESHOLD:
		front_animation.flip_h = true
		back_animation.flip_h = true
	else:
		front_animation.flip_h = false
		back_animation.flip_h = false

	# 面向鏡頭時，使用 front_frame, 背對鏡頭時，使用 back_frame。
	if model_back.dot(horizontal_camera_forward) > SCALAR_THRESHOLD:
		front_animation.visible = true
		back_animation.visible = false
	else:
		front_animation.visible = false
		back_animation.visible = true


func setup(unit_data) -> void:
	scale = Vector3.ONE * unit_data.sprite_size

	front_animation.setup(unit_data)
	back_animation.setup(unit_data)

	_update_facing()
	play(default_animation)


func play(animation_name: String) -> void:
	if animation_name in ["Idle", "Move"]:
		front_animation.play(animation_name)
		back_animation.play(animation_name)
	else:
		animation_player.play(animation_name)
		await animation_player.animation_finished
		play(default_animation)


func set_outline(enabled: bool) -> void:
	front_animation.set_outline(enabled)
	back_animation.set_outline(enabled)


func _on_sprite_animation_looped() -> void:
	if front_animation.animation not in looping_animations:
		play(default_animation)
