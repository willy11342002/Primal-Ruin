class_name ActionComponent
extends Node2D


@export var radius: float = 50.0
@export var node: Node


func click() -> void:
	var mouse_pos := get_global_mouse_position()
	var distance = global_position.distance_to(mouse_pos)
	if distance > radius:
		return

	if node and node.item and node.amount > 0:
		var action = node.item.action
		var data = node.item.data
		var result = _call_action(action, data)
		if result and node.item.consumable:
			node.amount -= 1
			node.update_display()
	else:
		_call_action("interact", null)


func _call_action(action: String, data: Resource) -> bool:
	for receiver in get_tree().get_nodes_in_group("ActionReceiver"):
		if receiver.has_method(action):
			var result = receiver.call(action, data)
			if result:
				return true
	return false
