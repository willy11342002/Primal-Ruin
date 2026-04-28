extends TileMapLayer


signal cell_dirty

var _modified_cells: Array[Vector2i] = []



func _ready() -> void:
	save_data.call_deferred()


func save_data() -> void:
	Persistence.data.tiles_data[name] = tile_map_data


func load_data() -> void:
	if Persistence.data.tiles_data.has(name):
		tile_map_data = Persistence.data.tiles_data[name]


func _process(_delta: float) -> void:
	cell_dirty.emit()


func set_cell_with_signal(
		coords: Vector2i,
		source_id: int = -1,
		atlas_coords: Vector2i = Vector2i(-1, -1),
		alternative_tile: int = 0
) -> void:
	set_cell(coords, source_id, atlas_coords, alternative_tile)
	_modified_cells.append(coords)


func set_cells_terrain_connect_with_signal(
		cells: Array,
		terrain_set: int,
		terrain: int,
		ignore_empty_terrains: bool = true
) -> void:
	set_cells_terrain_connect(cells, terrain_set, terrain, ignore_empty_terrains)
	_modified_cells.append_array(cells)


func set_cells_terrain_path_with_signal(
		cells: Array,
		terrain_set: int,
		terrain: int,
		ignore_empty_terrains: bool = true
) -> void:
	set_cells_terrain_path(cells, terrain_set, terrain, ignore_empty_terrains)
	_modified_cells.append_array(cells)
