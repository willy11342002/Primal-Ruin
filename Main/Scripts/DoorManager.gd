extends TileMapLayer


@export var auto_door_mode: bool = true: set = set_auto_door_mode
@export var layer: TileMapLayer
@export var physics_layer: Node
@export var auto_door_scene: PackedScene
@export var door_resources: Array[DoorResource]


func _ready() -> void:
	set_auto_door_mode.call_deferred(auto_door_mode)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Confirm", true):
		var mouse_pos := get_global_mouse_position()
		var coords := layer.local_to_map(mouse_pos)
		switch_door(coords)


func set_auto_door_mode(value: bool) -> void:
	auto_door_mode = value
	if auto_door_mode:
		for coords in layer.get_used_cells():
			update_auto_door(coords)
	else:
		for child in get_children():
			child.queue_free()


func _on_door_body_exited(body: Node, coords: Vector2i) -> void:
	if body.is_in_group("Player"):
		close_door.call_deferred(coords)


func _on_door_body_entered(body: Node, coords: Vector2i) -> void:
	if body.is_in_group("Player"):
		open_door.call_deferred(coords)


func update_auto_door(coords: Vector2i) -> void:
	var source_id := layer.get_cell_source_id(coords)
	var atlas := layer.get_cell_atlas_coords(coords)
	for res in door_resources:
		if source_id != res.source_id:
			continue
		if atlas != res.open_atlas and atlas != res.close_atlas:
			continue
		var door = auto_door_scene.instantiate()
		door.position = layer.map_to_local(coords)
		door.body_exited.connect(func(body): _on_door_body_exited(body, coords))
		door.body_entered.connect(func(body): _on_door_body_entered(body, coords))
		add_child(door)
		return


func switch_door(coords: Vector2i) -> void:
	var source_id := layer.get_cell_source_id(coords)
	var atlas := layer.get_cell_atlas_coords(coords)
	for res in door_resources:
		if source_id != res.source_id:
			continue
		if atlas == res.open_atlas:
			layer.set_cell(coords, res.source_id, res.close_atlas)
			physics_layer.update_coords.call_deferred(coords)
		elif atlas == res.close_atlas:
			layer.set_cell(coords, res.source_id, res.open_atlas)
			physics_layer.update_coords.call_deferred(coords)


func open_door(coords: Vector2i) -> void:
	var source_id := layer.get_cell_source_id(coords)
	var atlas := layer.get_cell_atlas_coords(coords)
	for res in door_resources:
		if source_id != res.source_id:
			continue
		if atlas == res.close_atlas:
			layer.set_cell(coords, res.source_id, res.open_atlas)
			physics_layer.update_coords.call_deferred(coords)


func close_door(coords: Vector2i) -> void:
	var source_id := layer.get_cell_source_id(coords)
	var atlas := layer.get_cell_atlas_coords(coords)
	for res in door_resources:
		if source_id != res.source_id:
			continue
		if atlas == res.open_atlas:
			layer.set_cell(coords, res.source_id, res.close_atlas)
			physics_layer.update_coords.call_deferred(coords)
