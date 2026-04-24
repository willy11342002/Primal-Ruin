extends HBoxContainer


var index: int = 0
var current_slot: HotKeySlot = null


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("CameraZoomIn"):
		prev_slot()
	if event.is_action_pressed("CameraZoomOut"):
		next_slot()


func _ready() -> void:
	load_data()
	_choose_slot(index)


func _choose_slot(new_index: int) -> void:
	if current_slot:
		current_slot.choose = false
		current_slot.update_display()
	index = new_index
	current_slot = get_child(index)
	current_slot.choose = true
	current_slot.update_display()
	
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		player.set_item(current_slot.slot)


func prev_slot() -> void:
	var new_index = (index - 1) % get_child_count()
	_choose_slot(new_index)


func next_slot() -> void:
	var new_index = (index + 1) % get_child_count()
	_choose_slot(new_index)


func load_data():
	for i in range(Persistence.data.hotkey_inventory.size()):
		var slot = Persistence.data.hotkey_inventory[i]
		var hotkey_slot = get_child(i)
		if hotkey_slot is HotKeySlot:
			hotkey_slot.set_slot(slot)


func save_data():
	var hotkey_inventory: Array[InventorySlot] = []
	for child in get_children():
		if child is HotKeySlot:
			hotkey_inventory.append(child.slot)
	Persistence.data.hotkey_inventory = hotkey_inventory
