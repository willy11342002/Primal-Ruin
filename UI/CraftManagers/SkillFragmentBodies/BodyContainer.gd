extends Area2D


@export var body_distance: float = 100.0
@export var body_speed: float = 5.0
@export var rotate_speed: float = 0.5
@export var body_scene: PackedScene
@onready var path2d: Path2D = $Path2D

var follows: Array = []
var craft_main: Node


func setup(_craft_main) -> void:
	craft_main = _craft_main


func add_body(fragment: SkillFragment) -> void:
	var body: PathFollow2D = body_scene.instantiate()
	path2d.add_child(body)

	var mouse_position: Vector2 = path2d.to_local(get_global_mouse_position())
	var closest_offset = path2d.curve.get_closest_offset(mouse_position)
	body.progress = closest_offset

	body.setup(fragment)
	body.drag_started.connect(craft_main._on_start_drag)
	body.hovered.connect(craft_main.show_fragment_detail)
	body.unhovered.connect(craft_main.close_fragment_detail)


func _physics_process(delta: float) -> void:
	path2d.rotate(rotate_speed * delta)

	for child in path2d.get_children():
		if child.is_queued_for_deletion():
			continue
		if child.get_child_count() == 0:
			child.queue_free()
			return
		
		# 根據索引計算目標進度，並平滑過渡
		var target_progress = body_distance * child.get_index()
		child.progress = move_toward(child.progress, target_progress, body_speed * delta)
