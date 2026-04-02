extends Node3D


var map_pos: Vector2i = Vector2i.ZERO
var world_pos: Vector3 = Vector3.INF

@onready var control: PlayerController = get_tree().get_first_node_in_group("Controller")


func _ready() -> void:
	control.cast_position_changed.connect(_on_cast_position_changed)


func reset() -> void:
	map_pos = Vector2i.ZERO
	world_pos = Vector3.INF
	hide()


func _on_cast_position_changed(_map_pos) -> void:
	if _map_pos == null:
		reset()
		return

	world_pos = NavServer.map_to_world(_map_pos)
	if world_pos == Vector3.INF:
		hide()
		return

	var unit = CombatServer.map_pos_to_unit(_map_pos)
	if unit:
		$Sprite3D.modulate = Global.CampColor[unit.unit_data.camp]
	else:
		$Sprite3D.modulate = Color.WHITE

	global_position = world_pos + Vector3(0, 0.01, 0)
	map_pos = _map_pos
	show()
