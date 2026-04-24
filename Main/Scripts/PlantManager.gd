extends Node


@export var ground_decorate_layer: TileMapLayer
@export var obstacle_layer: TileMapLayer
@export var farmland_source_id: int
@export var dry_farmland_atlas_coords: Vector2i
@export var wet_farmland_atlas_coords: Vector2i

@export var seed_source_id: int
@export var seed_atlas_coords: Vector2i

var plant_dic: Dictionary = {}


func sow_seed(plant: PlantResource) -> bool:
	var mouse_pos = ground_decorate_layer.get_global_mouse_position()
	var coords := ground_decorate_layer.local_to_map(mouse_pos)
	if obstacle_layer.get_cell_source_id(coords) == -1:
		if _is_dry_farmland(coords) or _is_wet_farmland(coords):
			obstacle_layer.set_cell(coords, seed_source_id, seed_atlas_coords)
			plant_dic[coords] = plant.duplicate()
			return true
	return false


func watering(_data: Resource) -> bool:
	var mouse_pos = ground_decorate_layer.get_global_mouse_position()
	var coords := ground_decorate_layer.local_to_map(mouse_pos)
	if _is_dry_farmland(coords):
		ground_decorate_layer.set_cell(coords, farmland_source_id, wet_farmland_atlas_coords)
		return true
	return false


func _is_dry_farmland(coords: Vector2i) -> bool:
	if ground_decorate_layer.get_cell_source_id(coords) == farmland_source_id:
		if ground_decorate_layer.get_cell_atlas_coords(coords) == dry_farmland_atlas_coords:
			return true
	return false


func _is_wet_farmland(coords: Vector2i) -> bool:
	if ground_decorate_layer.get_cell_source_id(coords) == farmland_source_id:
		if ground_decorate_layer.get_cell_atlas_coords(coords) == wet_farmland_atlas_coords:
			return true
	return false


func _on_next_day_button_up() -> void:
	for coords in plant_dic.keys():
		var plant = plant_dic[coords]
		if _is_wet_farmland(coords):
			var source = obstacle_layer.tile_set.get_source(plant.source_id)
			if not source:
				continue
			if not source.has_tile(plant.atlas_coords + Vector2i(plant.current_stage, 0) + Vector2i.RIGHT):
				continue
			if plant.grow():
				obstacle_layer.set_cell(coords, plant.source_id, plant.atlas_coords + Vector2i(plant.current_stage, 0))
