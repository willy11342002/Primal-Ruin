extends Node3D


var map_pos: Vector2i = Vector2i.ZERO
var world_pos: Vector3 = Vector3.INF

@onready var nav = get_tree().get_first_node_in_group("NavigationServer")
@onready var combat = get_tree().get_first_node_in_group("CombatServer")
@onready var control = get_tree().get_first_node_in_group("Controller")


func _ready() -> void:
	combat.hover_unit_changed.connect(_on_hover_unit_changed)
	control.cast_position_changed.connect(_on_cast_position_changed)


func reset() -> void:
	map_pos = Vector2i.ZERO
	world_pos = Vector3.INF
	hide()


func _on_cast_position_changed(_map_pos) -> void:
	if _map_pos == null:
		reset()
		return

	world_pos = nav.map_to_world(_map_pos)
	if world_pos == Vector3.INF:
		hide()
		return

	var unit = combat.map_pos_to_unit(_map_pos)
	if unit:
		combat.hover_on_unit(unit)
	else:
		combat.hover_off_unit(combat.hovered_unit)

	global_position = world_pos + Vector3(0, 0.01, 0)
	map_pos = _map_pos
	show()


func _on_hover_unit_changed(camp) -> void:
	if camp == null:
		$Sprite3D.modulate = Color.WHITE
		return
	
	$Sprite3D.modulate = Global.CampColor[camp]
