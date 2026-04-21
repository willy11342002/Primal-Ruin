extends TileMapLayer

@export var step_source_id: int = 0
@export var base_layers: Array[TileMapLayer]
@export var step_area_scene: PackedScene


func _ready() -> void:
	generate_step_areas()
	for character in get_tree().get_nodes_in_group("Character"):
		_on_body_exited(character)


func generate_step_areas() -> void:
	var rect := get_used_rect()
	
	for x in range(rect.position.x, rect.end.x):
		for y in range(rect.position.y, rect.end.y):
			var coords: Vector2i = Vector2i(x, y)
			var source_id: int = get_cell_source_id(coords)
			if source_id == step_source_id:
				create_area(coords)


func create_area(coords: Vector2i) -> Area2D:
	var area: Area2D = step_area_scene.instantiate()
	area.position = map_to_local(coords)
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	add_child(area)
	return area


func _on_body_entered(body) -> void:
	if body.is_in_group("Character"):
		body.set_collision_mask_value(1, false)
		body.set_collision_mask_value(2, false)
		body.set_collision_mask_value(3, false)


func _on_body_exited(body) -> void:
	var coords: Vector2i = local_to_map(body.position)
	# 還在階梯上, 不處理
	if get_cell_source_id(coords) == step_source_id:
		return
	for layer in base_layers:
		if layer.get_cell_source_id(coords) != -1:
			layer.place_on_layer(body)
			break
