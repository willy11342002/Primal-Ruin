extends HBoxContainer


var index: int = 0
var current_slot: HotKeySlot = null


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("CameraZoomIn"):
		next_slot()
	if event.is_action_pressed("CameraZoomOut"):
		prev_slot()


func _ready() -> void:
	for child in get_children():
		if child is HotKeySlot:
			child.update_display()

	_choose_slot(index)


func _choose_slot(new_index: int) -> void:
	if current_slot:
		current_slot.choose = false
		current_slot.update_display()
	index = new_index
	current_slot = get_child(index)
	current_slot.choose = true
	current_slot.update_display()



func prev_slot() -> void:
	var new_index = (index - 1) % get_child_count()
	_choose_slot(new_index)


func next_slot() -> void:
	var new_index = (index + 1) % get_child_count()
	_choose_slot(new_index)
