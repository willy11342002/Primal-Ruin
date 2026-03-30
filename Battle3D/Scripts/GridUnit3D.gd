@tool
class_name GridUnit3D
extends Node3D


@onready var nav = get_tree().get_first_node_in_group("NavigationServer")

var _last_valid_position: Vector3 = Vector3.ZERO


func _ready() -> void:
	_last_valid_position = global_position
	set_notify_transform(true)


func _notification(what: int) -> void:
	if not Engine.is_editor_hint(): return
	if not is_node_ready():
		call_deferred("_notification", what)
		return
	if what in [NOTIFICATION_TRANSFORM_CHANGED, NOTIFICATION_LOCAL_TRANSFORM_CHANGED]:
		var map_pos: Vector2i = nav.world_to_map(global_position)
		var world_pos: Vector3 = nav.map_to_world(map_pos)

		if world_pos == Vector3.INF:
			global_position = _last_valid_position
			return
		_last_valid_position = world_pos
		global_position = world_pos
