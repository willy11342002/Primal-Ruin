extends Node


@export var base_layers: Array[TileMapLayer]


func _ready() -> void:
	%NavigationLayer.base_layers = base_layers
	%PhysicsLayer.base_layers = base_layers

	generate_physics_and_navigation()


func _get_merged_rect() -> Rect2i:
	var merged_rect := Rect2i()
	for layer in base_layers:
		var used_rect = layer.get_used_rect()
		if used_rect.size == Vector2i.ZERO:
			continue
		if merged_rect.size == Vector2i.ZERO:
			merged_rect = used_rect
		else:
			merged_rect = merged_rect.merge(used_rect)
	return merged_rect


func generate_physics_and_navigation() -> void:
	var coords: Vector2i
	var rect := _get_merged_rect()
	for x in range(rect.position.x, rect.position.x + rect.size.x):
		for y in range(rect.position.y, rect.position.y + rect.size.y):
			coords = Vector2i(x, y)
			%PhysicsLayer.update_coords(coords)
			%NavigationLayer.update_coords(coords)
