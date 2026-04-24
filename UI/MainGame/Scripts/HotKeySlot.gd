class_name HotKeySlot
extends VBoxContainer


@export var choose: bool = false
@export var slot: InventorySlot


func _ready() -> void:
	if not slot:
		slot = InventorySlot.new()
	set_slot(slot)


func set_slot(new_slot: InventorySlot) -> void:
	if slot and slot.slot_changed.is_connected(update_display):
		slot.slot_changed.disconnect(update_display)

	slot = new_slot
	slot.slot_changed.connect(update_display)
	update_display()


func update_display() -> void:
	%Choosen.visible = choose

	if slot:
		if slot.amount > 0:
			%Icon.texture = slot.item.icon
			%Amount.text = str(slot.amount)
		else:
			slot = null
			update_display()
	else:
		%Icon.texture = null
		%Amount.text = ""
