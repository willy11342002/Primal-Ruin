extends AnimatedSprite3D


signal vfx_finished

var vfx: SkillVFX
var is_finished: bool = false


func setup(target_position: Vector3, _vfx: SkillVFX) -> void:
	vfx = _vfx
	global_position = target_position
	rotation_degrees = vfx.rotation
	offset = vfx.offset

	# 等待計時器，以及動畫結束
	get_tree().create_timer(vfx.wait_for_next).timeout.connect(_check_timeout)
	animation_finished.connect(_check_timeout)


func _check_timeout() -> void:
	if is_finished:
		call_deferred("queue_free")
		return
	
	vfx_finished.emit()
	is_finished = true
