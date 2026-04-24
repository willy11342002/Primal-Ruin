class_name InventorySlot
extends Resource


signal slot_changed(new_slot)


@export var item: ItemResource: set = set_item
@export var amount: int = 0: set = set_amount


func set_item(new_item: ItemResource) -> void:
	item = new_item
	slot_changed.emit()


func set_amount(new_amount: int) -> void:
	amount = new_amount
	slot_changed.emit()
