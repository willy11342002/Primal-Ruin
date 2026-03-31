class_name CombatUnitModel
extends Node3D


# cos(72°) ≈ 0.309, cos(73°) ≈ 0.292
const SCALAR_THRESHOLD: float = 0.306
const FLIP_THRESHOLD: float = 0.0

@export var default_animation: String = "Idle"
@export var front_animation: String = "Anim001"
@export var back_animation: String = "Anim002"

var unit: CombatUnit
var _camera_forward: Vector3 = Vector3.FORWARD


func _ready() -> void:
	set_notify_transform(true)

	var camera: PlayerController = get_tree().get_first_node_in_group("Controller")
	if camera:
		camera.rotation_changed.connect(_on_rotation_changed)
		camera.rotation_changed.emit(-camera.global_basis.z)

	play(default_animation)


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

	for child in get_children():
		if child is not AnimatedSprite3D:
			continue

		# 面相左側時，flip_h = true, 面相右側時，flip_h = false。
		if model_right.dot(horizontal_camera_forward) > FLIP_THRESHOLD:
			child.flip_h = true
		else:
			child.flip_h = false

		# 面向鏡頭時，使用 front_frame, 背對鏡頭時，使用 back_frame。
		if model_back.dot(horizontal_camera_forward) > SCALAR_THRESHOLD:
			child.animation = front_animation
		else:
			child.animation = back_animation


func setup(unit_data) -> void:
	scale = Vector3.ONE * unit_data.sprite_size
	for child in get_children():
		child.setup(unit_data)
	play("Idle")


func play(animation_name: String) -> void:
	for child in get_children():
		if child.name == animation_name:
			child.show()
			child.play()
		else:
			child.hide()
			child.stop()


func set_outline(enabled: bool) -> void:
	for child in get_children():
		child.set_outline(enabled)
