extends TileMapLayer


@export var layer_id: int = 0
@export var collision_layers: Array[int] = []


func place_on_layer(body) -> void:
	for layer in collision_layers:
		body.set_collision_mask_value(layer, true)


func _ready() -> void:
	tile_set = tile_set.duplicate()
	tile_set.set_physics_layer_collision_layer(0, layer_id)
