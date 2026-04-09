extends Container


@export var slot_scene: PackedScene

var display_fragments: Array[SkillFragment]
var craft_main: Node


func setup(_craft_main) -> void:
	craft_main = _craft_main
	
	display_fragments = craft_main.total_fragments.duplicate()
	update_display_fragments()


func update_display_fragments() -> void:
	for child in get_children():
		child.queue_free()
	
	for fragment in display_fragments:
		add_slot(fragment)


func add_slot(fragment: SkillFragment) -> void:
	var slot = slot_scene.instantiate()
	slot.setup(fragment)
	# 綁定訊號
	slot.drag_started.connect(craft_main._on_start_drag)
	slot.hovered.connect(craft_main.show_fragment_detail)
	slot.unhovered.connect(craft_main.close_fragment_detail)
	add_child(slot)
