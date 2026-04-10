extends Area2D


@export var body_distance: float = 100.0
@export var body_speed: float = 5.0
@export var rotate_speed: float = 0.5
@export var body_scene: PackedScene

var craft_main: Node


func setup(_craft_main) -> void:
	$Line2D.clear_points()
	craft_main = _craft_main


func add_body(fragment: SkillFragment) -> void:
	var body: Node2D = body_scene.instantiate()
	$Line2D.add_child(body)

	body.setup(fragment)
	body.global_position = get_global_mouse_position()
	body.drag_started.connect(craft_main._on_start_drag)
	body.hovered.connect(craft_main.show_fragment_detail)
	body.unhovered.connect(craft_main.close_fragment_detail)


func _process(_delta: float) -> void:
	for child in $Line2D.get_children():
		$Line2D.set_point_position(child.get_index(), child.position)


func _on_child_entered_tree(node: Node) -> void:
	$Line2D.add_point(node.position)


func _on_child_exiting_tree(node: Node) -> void:
	craft_main.skill_data.fragments.pop_at(node.get_index())
	$Line2D.remove_point(node.get_index())
