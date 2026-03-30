class_name CombatUnit
extends Node3D


@onready var unit_model: CombatUnitModel = %CombatUnitModel
@onready var move_component: CombatUnitMovement3D = %CombatUnitMovement3D
@export var unit_data: UnitData

@warning_ignore("unused_signal") signal health_depleted(c: CombatUnit)
@warning_ignore("unused_signal") signal update_requested


func setup(_data: UnitData) -> void:
	unit_data = _data
	unit_data.unit = self
	unit_data.end_turn()
	unit_model.setup(unit_data)


func play_animation(ani_name: String) -> void:
	unit_model.play(ani_name)


func move_alone_path(path: Array) -> void:
	play_animation("Move")
	move_component.move_alone_path(path)
	await move_component.move_finished
	play_animation("Idle")


func hover_on() -> void:
	unit_model.set_outline(true)


func hover_off() -> void:
	unit_model.set_outline(false)
