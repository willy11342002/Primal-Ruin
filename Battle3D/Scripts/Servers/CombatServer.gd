extends Node


signal hover_unit_changed(new_unit)

@onready var nav = get_tree().get_first_node_in_group("NavigationServer")
@export var unit_scene: PackedScene
@export var units_container: Node

var combat_data: CombatData
var current_unit: CombatUnit: get = get_current_unit
var hovered_unit: CombatUnit = null


func hover_on_unit(unit: CombatUnit) -> void:
	hovered_unit = unit
	hover_unit_changed.emit(unit.unit_data.camp)


func hover_off_unit(unit: CombatUnit) -> void:
	if hovered_unit == unit:
		hovered_unit = null
		hover_unit_changed.emit(null)


func map_pos_to_unit(map_pos: Variant) -> CombatUnit:
	for unit in get_tree().get_nodes_in_group("CombatUnit"):
		if unit is CombatUnit:
			var unit_map_pos = nav.world_to_map(unit.global_position)
			if unit_map_pos == map_pos:
				return unit
	return


func deplete_unit(unit: CombatUnit) -> void:
	combat_data.units.erase(unit.unit_data)
	unit.play_animation("Die")


func get_current_unit() -> CombatUnit:
	combat_data.units.sort_custom(func(a, b):
		return a.next_time < b.next_time
	)
	return combat_data.units[0].unit


func show_move_range(unit: CombatUnit) -> Dictionary:
	var map_pos = nav.world_to_map(unit.global_position)
	var distances = nav.find_range(map_pos, unit.unit_data.balance_movement)
	nav.show_range(unit.unit_data.camp, distances)
	return distances


func clear_units() -> void:
	for child in units_container.get_children():
		child.queue_free()


func add_unit(_data: UnitData, pos: Vector2i) -> CombatUnit:
	var unit: CombatUnit = unit_scene.instantiate()
	units_container.add_child(unit)
	unit.global_position = nav.map_to_world(pos)
	unit.setup(_data)
	unit.health_depleted.connect(deplete_unit)
	return unit


func get_unit_info(unit: CombatUnit) -> Dictionary:
	nav.clear_preview()
	if unit == null:
		return {}

	var distances: Dictionary = show_move_range(unit)
	return {
		"unit": unit,
		"move_distances": distances,
		"path": []
	}


func move_unit_alone_path(unit: CombatUnit, path: Array, cost: float) -> void:
	Global.pause_player_input.emit(true)
	await unit.move_alone_path(path)
	unit.unit_data.balance_movement -= cost
	Global.pause_player_input.emit(false)
