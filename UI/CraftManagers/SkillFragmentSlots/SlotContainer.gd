extends Container


@export var slot_scene: PackedScene

var craft_main: Node


func setup(_craft_main) -> void:
	craft_main = _craft_main
	craft_main.display_fragments_updated.connect(update_display_fragments)
	await update_display_fragments()


func update_display_fragments() -> void:
	if child_exiting_tree.is_connected(_on_child_exiting_tree):
		child_exiting_tree.disconnect(_on_child_exiting_tree)

	for child in get_children():
		child.queue_free()
	
	await get_tree().process_frame
	for fragment in craft_main.display_fragments:
		add_slot(fragment)

	child_exiting_tree.connect(_on_child_exiting_tree)


func add_slot(fragment: SkillFragment) -> void:
	var slot = slot_scene.instantiate()
	slot.setup(fragment)
	# 綁定訊號
	slot.drag_started.connect(craft_main._on_start_drag)
	slot.hovered.connect(craft_main.show_fragment_detail)
	slot.unhovered.connect(craft_main.close_fragment_detail)
	add_child(slot)


func _on_child_exiting_tree(node: Node) -> void:
	craft_main.display_fragments.pop_at(node.get_index())
	await update_display_fragments()
