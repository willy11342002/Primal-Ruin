class_name CombatUnitMovement
extends Node3D


signal move_started
signal move_updated
signal move_finished

@onready var unit: CombatUnit = get_parent() as CombatUnit
@export var move_duration: float = 0.3

var path: Array[Vector2i] = []


func move_alone_path(_path: Array) -> void:
	path.clear()
	for point in _path:
		match point:
			_ when point is Vector2i:
				path.append(point)
			_ when point is Vector3:
				path.append(NavServer.world_to_map(point))
			_:
				push_error("Invalid path point: " + str(point))
	move_started.emit()
	move_to_next_point()


func move_to_next_point() -> void:
	if path.is_empty():
		move_finished.emit()
		return

	var next_point: Vector2i = path.pop_front()
	var next_position: Vector3 = NavServer.map_to_world(next_point)
	if global_position == next_position:
		move_to_next_point()
		return
	if next_position == Vector3.INF:
		push_error("Invalid path point: " + str(next_point))
		move_to_next_point()
		return

	unit.look_at(Vector3(next_position.x, global_position.y, next_position.z), Vector3.UP)

	var tween: Tween = create_tween()
	tween.parallel()\
		.tween_property(unit, "global_position:x", next_position.x, move_duration)\
		.set_trans(Tween.TRANS_LINEAR)
	tween.parallel()\
		.tween_property(unit, "global_position:z", next_position.z, move_duration)\
		.set_trans(Tween.TRANS_LINEAR)
	tween.parallel()\
		.tween_property(unit, "global_position:y", next_position.y, move_duration)\
		.set_ease(Tween.EASE_IN_OUT)\
		.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(move_to_next_point)
	move_updated.emit()
