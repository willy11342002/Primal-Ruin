class_name ActionComponent
extends Node2D


@export var radius: float = 50.0
@export var slot: InventorySlot


func use_tool() -> bool:
	var mouse_pos := get_global_mouse_position()
	var distance = global_position.distance_to(mouse_pos)
	if distance > radius:
		return false

	if not slot or slot.amount <= 0:
		return false

	var action = slot.item.action
	var data = slot.item.data
	var result = _call_action(action, data)
	if result and slot.item.consumable:
		slot.amount -= 1
	return result


func interact() -> bool:
	return _call_action("interact")



func _call_action(action: String, data: Resource=null) -> bool:
	for receiver in get_tree().get_nodes_in_group("ActionReceiver"):
		if receiver.has_method(action):
			var result = receiver.call(action, data)
			if result:
				return true
	return false
