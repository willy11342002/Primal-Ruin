extends Control

@export var preview_scene: PackedScene

var craft_main: Node
var preview_instance: Node


func setup(_craft_main) -> void:
	craft_main = _craft_main


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			if preview_instance:
				craft_main._handle_drag_end()



func add_preview(data: SkillFragment) -> Node:
	preview_instance = preview_scene.instantiate()
	add_child(preview_instance)

	preview_instance.setup(data)
	preview_instance.hovered.connect(craft_main.show_fragment_detail)
	preview_instance.unhovered.connect(craft_main.close_fragment_detail)
	preview_instance.global_position = get_global_mouse_position()
	return preview_instance


func remove_preview() -> void:
	if preview_instance and preview_instance.is_inside_tree():
		preview_instance.queue_free()
		preview_instance = null
