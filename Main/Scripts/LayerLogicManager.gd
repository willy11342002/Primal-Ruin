extends Node


@export var trigger_layers: Array[TileMapLayer]


func _ready() -> void:
	# 連接信號
	for layer in trigger_layers:
		layer.cell_dirty.connect(_on_cell_dirty)

	# 初始生成一次物理和導航數據
	generate_physics_and_navigation.call_deferred()


func _get_merged_rect() -> Rect2i:
	var merged_rect := Rect2i()
	for layer in trigger_layers:
		var used_rect = layer.get_used_rect()
		if used_rect.size == Vector2i.ZERO:
			continue
		if merged_rect.size == Vector2i.ZERO:
			merged_rect = used_rect
		else:
			merged_rect = merged_rect.merge(used_rect)
	return merged_rect


func _update_coords(coords: Vector2i) -> void:
	%PhysicsLayer.update_coords(coords)
	%NavigationLayer.update_coords(coords)


func _on_cell_dirty() -> void:
	var handled_coords: Array = []
	for layer in trigger_layers:
		handled_coords.append_array(layer._modified_cells)
		layer._modified_cells.clear()

	for coords in handled_coords:
		_update_coords(coords)


func load_data() -> void:
	generate_physics_and_navigation.call_deferred()


func generate_physics_and_navigation() -> void:
	var rect := _get_merged_rect()
	for x in range(rect.position.x, rect.position.x + rect.size.x):
		for y in range(rect.position.y, rect.position.y + rect.size.y):
			_update_coords(Vector2i(x, y))
