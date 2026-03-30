class_name Battle
extends Node


@export var data: CombatData


func _ready() -> void:
	if data:
		setup(data)


func setup(_data: CombatData) -> void:
	Global.combat.clear_units()

	_create_units(_data)
	Global.combat.combat_data = _data


func _create_units(_data: CombatData) -> void:
	for u_data in _data.units:
		var points = Global.nav.base_level.get_camp_spawn_points(u_data.camp)
		for point in points:
			if not Global.combat.map_pos_to_unit(point):
				var unit = Global.combat.add_unit(u_data, point)
				print(unit.name + ", 優先度: " + str(u_data.next_time))
				break
