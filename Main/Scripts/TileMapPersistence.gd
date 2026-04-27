extends TileMapLayer


func _ready() -> void:
	save_data.call_deferred()


func save_data() -> void:
	Persistence.data.tiles_data[name] = tile_map_data


func load_data() -> void:
	if Persistence.data.tiles_data.has(name):
		tile_map_data = Persistence.data.tiles_data[name]
	
