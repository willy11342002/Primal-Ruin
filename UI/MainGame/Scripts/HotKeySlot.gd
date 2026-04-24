class_name HotKeySlot
extends VBoxContainer


@export var choose: bool = false
@export var item: ItemResource
@export var amount: int = 0


func update_display() -> void:
	%Choosen.visible = choose

	if item:
		if amount > 0:
			%Icon.texture = item.icon
			%Amount.text = str(amount)
		else:
			item = null
			update_display()
	else:
		%Icon.texture = null
		%Amount.text = ""
