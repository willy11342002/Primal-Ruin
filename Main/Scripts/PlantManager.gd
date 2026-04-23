extends Node


@export var ground_decorate_layer: TileMapLayer
@export var obstacle_layer: TileMapLayer
@export var farmland_source_id: int
@export var dry_farmland_atlas_coords: Vector2i
@export var wet_farmland_atlas_coords: Vector2i

@export var seed_source_id: int
@export var seed_atlas_coords: Vector2i

@export var plant_resource: PlantResource

var plant_dic: Dictionary = {}


func sow_seed(plant: PlantResource, coords: Vector2i) -> void:
	obstacle_layer.set_cell(coords, plant.source_id, plant.atlas_coords)
	plant_dic[coords] = plant


func watering(coords: Vector2i) -> void:
	ground_decorate_layer.set_cell(coords, farmland_source_id, wet_farmland_atlas_coords)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Confirm", false):
		var mouse_pos = ground_decorate_layer.get_global_mouse_position()
		var coords := ground_decorate_layer.local_to_map(mouse_pos)

		# 障礙物層必須為空
		if obstacle_layer.get_cell_source_id(coords) != -1:
			return

		# 如果是濕田，變成播種後的田
		if _is_wet_farmland(coords):
			sow_seed(plant_resource.duplicate(), coords)

		# 如果是乾田，變成濕田
		if _is_dry_farmland(coords):
			watering(coords)


func _is_dry_farmland(coords: Vector2i) -> bool:
	return ground_decorate_layer.get_cell_source_id(coords) == farmland_source_id and ground_decorate_layer.get_cell_atlas_coords(coords) == dry_farmland_atlas_coords


func _is_wet_farmland(coords: Vector2i) -> bool:
	return ground_decorate_layer.get_cell_source_id(coords) == farmland_source_id and ground_decorate_layer.get_cell_atlas_coords(coords) == wet_farmland_atlas_coords


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
