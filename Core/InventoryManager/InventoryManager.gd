extends Node


var dic_slots: Dictionary[String, Array] = {}


func clear_slots(_name: String) -> void:
	dic_slots[_name] = []


func add_slot(_name: String, slot: InventorySlot) -> void:
	if not dic_slots.has(_name):
		dic_slots[_name] = []
	dic_slots[_name].append(slot)


func add_item(item: ItemResource, amount: int) -> bool:
	for slots in dic_slots.values():
		for slot in slots:
			if slot.item == item:
				slot.amount = slot.amount + amount
				return true

	for slots in dic_slots.values():
		for slot in slots:
			if slot.amount == 0:
				slot.item = item
				slot.amount = amount
				return true

	print("No space in inventory for item: " + item.name)
	return false
