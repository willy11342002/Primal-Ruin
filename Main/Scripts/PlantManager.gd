extends Node


@export var ground_decorate_layer: TileMapLayer
@export var obstacle_layers: Array[TileMapLayer]
@export var plant_layer: TileMapLayer
@export var farm_source_ids: Array[int]
@export var farmland_source_id: int
@export var dry_farmland_atlas_coords: Vector2i
@export var wet_farmland_atlas_coords: Vector2i

var plant_days_dic: Dictionary = {}


func load_data() -> void:
	plant_days_dic = Persistence.data.plant_days_dic.duplicate(true)


func save_data() -> void:
	Persistence.data.plant_days_dic = plant_days_dic.duplicate(true)


func sow_seed(_executor: Node, target_position: Vector2, plant: PlantResource) -> bool:
	var coords := ground_decorate_layer.local_to_map(target_position)
	if _is_obstacle_empty(coords):
		if _is_dry_farmland(coords) or _is_wet_farmland(coords):
			plant_layer.set_cell_with_signal(coords, plant.source_id, plant.atlas_coords)
			plant_days_dic[coords] = 0
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
	var source_id: int = plant_layer.get_cell_source_id(coords)
	if source_id in farm_source_ids:
		return _harvest_coorp(coords)
	return false


func _get_custom_data(key: String, coords: Vector2i) -> Variant:
	var data = plant_layer.get_cell_tile_data(coords)
	if data == null:
		return null
	return data.get_custom_data(key)


func _get_plant_resource(coords: Vector2i) -> PlantResource:
	var data = plant_layer.get_cell_tile_data(coords)
	var uid = data.get_custom_data("coorp_uid")
	if uid == null:
		return null
	return load(uid)


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


func _grow_coorp(coords: Vector2i) -> void:
	var source_id: int = plant_layer.get_cell_source_id(coords)
	if source_id == -1:
		return

	var grow_days = _get_custom_data("grow_days", coords)
	if grow_days in [null, -1, 0]:
		return

	if not plant_days_dic.has(coords):
		plant_days_dic[coords] = 0
	plant_days_dic[coords] += 1
	if plant_days_dic[coords] < grow_days:
		return
	
	var atlas = plant_layer.get_cell_atlas_coords(coords)
	var next_stage: Vector2i = _get_custom_data("next_stage", coords)
	plant_layer.set_cell_with_signal(coords, source_id, atlas + next_stage)
	plant_days_dic[coords] = 0


func _harvest_coorp(coords: Vector2i) -> bool:
	if _get_custom_data("grow_days", coords) != -1:
		return false
	
	var resource = _get_plant_resource(coords)
	if not resource:
		return false

	if resource.multiple_harvest:
		var source_id: int = plant_layer.get_cell_source_id(coords)
		var atlas = plant_layer.get_cell_atlas_coords(coords)
		var next_stage: Vector2i = _get_custom_data("next_stage", coords)
		plant_days_dic[coords] = 0
		plant_layer.set_cell_with_signal(coords, source_id, atlas + next_stage)
		print("harvest plant at ", coords)
	else:
		plant_layer.erase_cell(coords)
		plant_days_dic.erase(coords)
		print("erase plant at ", coords)

	InventoryManager.add_item(resource.harvest, 1)
	return true


func _on_check_during_across_days() -> void:
	for coords in plant_layer.get_used_cells():
		var source_id: int = plant_layer.get_cell_source_id(coords)
		if source_id in farm_source_ids and _is_wet_farmland(coords):
			_grow_coorp(coords)
		else:
			_grow_coorp(coords)

	for coords in ground_decorate_layer.get_used_cells():
		if _is_wet_farmland(coords):
			ground_decorate_layer.set_cell(coords, farmland_source_id, dry_farmland_atlas_coords)
