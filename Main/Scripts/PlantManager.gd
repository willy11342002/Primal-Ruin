extends Node


@export var ground_decorate_layer: TileMapLayer
@export var obstacle_layers: Array[TileMapLayer]
@export var plant_layer: TileMapLayer
@export var farmland_source_id: int
@export var dry_farmland_atlas_coords: Vector2i
@export var wet_farmland_atlas_coords: Vector2i

var plant_dic: Dictionary = {}
var plant_info: Dictionary = {
	"current_days": 0,
}

func load_data() -> void:
	plant_dic = Persistence.data.plants_data.duplicate(true)


func save_data() -> void:
	Persistence.data.plants_data = plant_dic.duplicate(true)


func sow_seed(_executor: Node, target_position: Vector2, plant: PlantResource) -> bool:
	var coords := ground_decorate_layer.local_to_map(target_position)
	if _is_obstacle_empty(coords):
		if _is_dry_farmland(coords) or _is_wet_farmland(coords):
			plant_layer.set_cell_with_signal(coords, plant.source_id, plant.atlas_coords)
			plant_dic[coords] = plant_info.duplicate()
			return true
	return false


func watering(_executor: Node, target_position: Vector2, _data: Resource) -> bool:
	var coords := ground_decorate_layer.local_to_map(target_position)
	if _is_dry_farmland(coords):
		ground_decorate_layer.set_cell_with_signal(coords, farmland_source_id, wet_farmland_atlas_coords)
		return true
	return false


func interact(_executor: Node, target_position: Vector2, _data: Resource) -> bool:
	var coords := plant_layer.local_to_map(target_position)
	var source_id = plant_layer.get_cell_source_id(coords)
	var info = plant_dic.get(coords, null)
	var data = plant_layer.get_cell_tile_data(coords)
	if not data:
		return false
	if not info:
		return false
	if data.get_custom_data("grow_days") != -1:
		return false

	if data.get_custom_data("multiple_harvest"):
		var atlas = plant_layer.get_cell_atlas_coords(coords)
		info.current_days = 0
		plant_layer.set_cell(coords, source_id, atlas - Vector2i(1, 0))
	else:	
		plant_layer.erase_cell(coords)
		plant_dic.erase(coords)

	InventoryManager.add_item(data.get_custom_data("coorps"), 1)
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


func _on_check_during_across_days() -> void:
	for coords in ground_decorate_layer.get_used_cells():
		if not _is_wet_farmland(coords):
			continue

		# 土地變乾
		ground_decorate_layer.set_cell_with_signal(coords, farmland_source_id, dry_farmland_atlas_coords)

		var source_id: int = plant_layer.get_cell_source_id(coords)
		if source_id == -1:
			continue

		var tile_data = plant_layer.get_cell_tile_data(coords)
		if not tile_data:
			continue
		
		var grow_days: int = tile_data.get_custom_data("grow_days")
		if grow_days in [null, -1, 0]:
			continue

		var info: Dictionary = plant_dic.get(coords, plant_info)
		info.current_days += 1

		if info.current_days < grow_days:
			continue
		
		var atlas = plant_layer.get_cell_atlas_coords(coords)
		var next_stage: Vector2i = tile_data.get_custom_data("next_stage")
		plant_layer.set_cell_with_signal(coords, source_id, atlas + next_stage)
		info.current_days = 0

		# var plant = plant_dic.get(coords, null)
		# if not plant:
		# 	continue

		# var source = plant_layer.tile_set.get_source(plant.source_id)
		# if not source:
		# 	continue
		# if not source.has_tile(plant.atlas_coords + Vector2i(plant.current_stage, 0) + Vector2i.RIGHT):
		# 	continue
		# if plant.grow():
		# 	plant_layer.set_cell_with_signal(coords, plant.source_id, plant.atlas_coords + Vector2i(plant.current_stage, 0))
