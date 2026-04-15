@tool
extends Node3D


func _process(_delta: float) -> void:
	var camera: Camera3D
	if Engine.is_editor_hint():
		camera = EditorInterface.get_editor_viewport_3d().get_camera_3d()
	else:
		camera = get_viewport().get_camera_3d()
	if not camera: return

	var target_pos: Vector3 = camera.global_position
	target_pos.y = global_position.y
	if global_position.distance_to(target_pos) > 0.001:
		var forward = (camera.global_position - global_position).normalized()
		forward.y = 0
		forward.normalized()
		
		look_at(global_position - forward, Vector3.UP)

		#look_at(target_pos, Vector3.UP)
		#rotate_object_local(Vector3.UP, PI)
