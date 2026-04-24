extends Node


@export var ground_decorate_layer: TileMapLayer
@export var obstacle_layers: Array[TileMapLayer]
@export var plant_layer: TileMapLayer
@export var farmland_source_id: int
@export var dry_farmland_atlas_coords: Vector2i
@export var wet_farmland_atlas_coords: Vector2i

var plant_dic: Dictionary = {}


func sow_seed(plant: PlantResource) -> bool:
	var mouse_pos = ground_decorate_layer.get_global_mouse_position()
	var coords := ground_decorate_layer.local_to_map(mouse_pos)
	if _is_obstacle_empty(coords):
		if _is_dry_farmland(coords) or _is_wet_farmland(coords):
			plant_layer.set_cell(coords, plant.source_id, plant.atlas_coords)
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


func interact(_data: Resource) -> bool:
	var mouse_pos = plant_layer.get_global_mouse_position()
	var coords := plant_layer.local_to_map(mouse_pos)
	var plant = plant_dic.get(coords, null)
	if not plant:
		return false
	if plant.current_stage < plant.growth_time.size():
		return false

	if plant.multiple_harvest:
		plant.current_stage -= 1
		plant.current_days = 0
		plant_layer.set_cell(coords, plant.source_id, plant.atlas_coords + Vector2i(plant.current_stage, 0))
	else:	
		plant_layer.erase_cell(coords)
		plant_dic.erase(coords)

	return true


func _is_obstacle_empty(coords: Vector2i) -> bool:
	for layer in obstacle_layers:
		if layer.get_cell_source_id(coords) != -1:
			return false
	return true


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
	for coords in ground_decorate_layer.get_used_cells():
		if _is_wet_farmland(coords):
			ground_decorate_layer.set_cell(coords, farmland_source_id, dry_farmland_atlas_coords)

			var plant = plant_dic.get(coords, null)
			if not plant:
				continue

			var source = plant_layer.tile_set.get_source(plant.source_id)
			if not source:
				continue
			if not source.has_tile(plant.atlas_coords + Vector2i(plant.current_stage, 0) + Vector2i.RIGHT):
				continue
			if plant.grow():
				plant_layer.set_cell(coords, plant.source_id, plant.atlas_coords + Vector2i(plant.current_stage, 0))


func _on_add_item_button_up() -> void:
	InventoryManager.add_item(preload("uid://bspqxfnltaxmo"), 1)
