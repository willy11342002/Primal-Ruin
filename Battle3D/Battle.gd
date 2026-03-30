class_name Battle
extends Node


@onready var combat = get_tree().get_first_node_in_group("CombatServer")
@onready var nav = get_tree().get_first_node_in_group("NavigationServer")
@export var data: CombatData


func _ready() -> void:
	if data:
		setup(data)


func setup(_data: CombatData) -> void:
	combat.clear_units()

	_create_units(_data)
	combat.combat_data = _data


func _create_units(_data: CombatData) -> void:
	for u_data in _data.units:
		var points = nav.base_level.get_camp_spawn_points(u_data.camp)
		for point in points:
			if not combat.map_pos_to_unit(point):
				var unit = combat.add_unit(u_data, point)
				print(unit.name + ", 優先度: " + str(u_data.next_time))
				break
