extends Node


var slots: Array[InventorySlot]:
	get:
		return Persistence.data.hotkey_inventory


func add_item(item: ItemResource, amount: int) -> bool:
	for slot in slots:
		if slot.item == item:
			slot.amount = slot.amount + amount
			return true

	for slot in slots:
		if slot.amount == 0:
			slot.item = item
			slot.amount = amount
			return true

	print("No space in inventory for item: " + item.name)
	return false
