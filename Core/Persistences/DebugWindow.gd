extends Control


@onready var name_filter: LineEdit = %NameFilter
@onready var item_list: ItemList = %ItemList
@onready var item_db: ResourcePreloader = $ItemDB
@onready var item_title: Button = %ItemTitle
@onready var add_item_spin: SpinBox = %AddItemSpin

var item: ItemResource:
	set(value):
		item = value
		if item:
			item_title.text = item.name
			item_title.icon = item.icon
		else:
			item_title.text = ""
			item_title.icon = null


func _on_visibility_changed() -> void:
	if is_visible_in_tree():
		name_filter.grab_focus()


func _ready() -> void:
	update_item_list.call_deferred()


func _on_name_filter_text_submitted(_new_text: String) -> void:
	update_item_list.call_deferred()


func _on_item_list_item_selected(index: int) -> void:
	item = item_db.get_resource(item_list.get_item_text(index))


func _on_item_list_item_activated(index: int) -> void:
	item = item_db.get_resource(item_list.get_item_text(index))
	InventoryManager.add_item(item, int(add_item_spin.value))


func _on_add_item_button_button_up() -> void:
	InventoryManager.add_item(item, int(add_item_spin.value))


func update_item_list() -> void:
	item_list.clear()
	var filter: String = name_filter.text
	for res_name in item_db.get_resource_list():
		if filter == "":
			item_list.add_item(res_name)
		elif res_name.findn(filter) != -1:
			item_list.add_item(res_name)
		elif tr(res_name).findn(filter) != -1:
			item_list.add_item(res_name)
