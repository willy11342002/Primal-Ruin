class_name ActionComponent
extends Node


@onready var entity: CharacterBody2D = get_parent()
@export var nav_component: Node
@export var radius: float = 50.0
@export var slot: InventorySlot


func use_tool() -> bool:
	if not slot or slot.item == null or slot.amount <= 0:
		return false

	var mouse_pos := entity.get_global_mouse_position()
	if await _detect_distance():
		var action = slot.item.action
		var data = slot.item.data
		var result = _call_action(action, mouse_pos, data)
		if result and slot.item.consumable:
			slot.amount -= 1
		return result
	return false


func interact() -> bool:
	if await _detect_distance():
		return _call_action("interact", entity.get_global_mouse_position())
	return false


func _detect_distance() -> bool:
	var mouse_pos := entity.get_global_mouse_position()
	var distance = entity.global_position.distance_to(mouse_pos)
	if distance <= radius:
		return true

	nav_component.move_to(mouse_pos)
	var first_singal = await Global.any_signal([
		nav_component.navigation_finished,
		nav_component.navigation_interrupted,
	])

	if first_singal == nav_component.navigation_finished:
		return true

	return false


func _call_action(action: String, target_position: Vector2, data: Resource=null) -> bool:
	for receiver in get_tree().get_nodes_in_group("ActionReceiver"):
		if receiver.has_method(action):
			var result = receiver.call(action, entity, target_position, data)
			if result:
				return true
	return false
