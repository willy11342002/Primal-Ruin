class_name HotKeySlot
extends VBoxContainer


@export var choose: bool = false
@export var data: ItemResource
@export var amount: int


func update_display() -> void:
	%Choosen.visible = choose

	if data:
		%Icon.texture = data.icon
		%Amount.text = str(amount)
	else:
		%Icon.texture = null
		%Amount.text = ""
