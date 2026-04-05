@tool
extends Node


const NEIGHBOR_OFFSETS: Array[Vector2i] = [
	Vector2i.UP,
	Vector2i.DOWN,
	Vector2i.LEFT,
	Vector2i.RIGHT,
]

@export var HEIGHT_COST_MULTIPLIER: float = 3.0
@export var move_preview_scene: PackedScene
@export var path_resources: Array[PathResource] = []

var preview_dic: Dictionary = {}


var base_level: CustomTileMapLayer3D:
	get:
		return get_tree().get_first_node_in_group("Level")


func local_to_map(world_pos: Vector3) -> Vector2i:
	return base_level.local_to_map(world_pos)


func map_to_local(map_pos: Vector2i) -> Vector3:
	return base_level.map_to_local(map_pos)


func local_to_grid(world_pos: Vector3) -> Vector3:
	return base_level.local_to_grid(world_pos)


func grid_to_local(grid_pos: Vector3) -> Vector3:
	return base_level.grid_to_local(grid_pos)


func grid_to_map(grid_pos: Vector3) -> Vector2i:
	return base_level.grid_to_map(grid_pos)


func map_to_grid(map_pos: Vector2i, height: float = -0.5) -> Vector3:
	return base_level.map_to_grid(map_pos, height)



## 使用BFS演算法, 計算從起始位置出發, 在指定距離內所有可到達的位置
## pass_func: Callable( Vector2i ) -> bool, 回傳 true 表示跳過
func find_range(start_pos: Vector2i, _range: float, pass_func: Callable = Callable(), exclude_func: Callable = Callable()) -> Dictionary:
	var queue: Array = [start_pos]
	var distances: Dictionary = {start_pos: 0.0}

	while not queue.is_empty():
		var current_pos: Vector2i = queue.pop_front()
		var current_dist: float = distances[current_pos]
		var current_height = base_level.get_heightest_tile_at(current_pos).y

		for neighbor in NEIGHBOR_OFFSETS:
			var neighbor_pos = current_pos + neighbor

			if pass_func.is_valid() and pass_func.call(neighbor_pos):
				continue

			var n_height = base_level.get_heightest_tile_at(neighbor_pos).y
			if n_height == -INF:
				continue

			# 計算到達鄰居的新距離
			var step_cost = 1.0 + HEIGHT_COST_MULTIPLIER * absf(absf(n_height) - absf(current_height))
			var total_dist = current_dist + step_cost

			# 只有在距離小於範圍，且（尚未記錄過 或 找到更短路徑）時才處理
			if total_dist <= _range:
				if not neighbor_pos in distances or total_dist < distances[neighbor_pos]:
					distances[neighbor_pos] = total_dist
					queue.push_back(neighbor_pos)

	for pos in distances.keys():
		if exclude_func.is_valid() and exclude_func.call(pos):
			distances.erase(pos)

	return distances


## 根據BFS演算法結果, 從目標往回推找出最短路徑
func find_path_from_range(distances: Dictionary, target_pos: Variant) -> Array:
	if target_pos not in distances:
		return []
	
	var current: Vector2i = target_pos
	var _path: Array = [target_pos]

	while true:
		if distances[current] == 0:
			break
		var best_neighbor: Variant = null
		var best_cost: float = distances[current]
		for neighbor in NEIGHBOR_OFFSETS:
			var neighbor_pos: Vector2i = current + neighbor
			if neighbor_pos not in distances:
				continue
			if distances[neighbor_pos] < best_cost:
				best_cost = distances[neighbor_pos]
				best_neighbor = neighbor_pos
		if best_neighbor == null:
			break
		current = best_neighbor
		_path.append(current)
	_path.reverse()
	return _path


func clear_preview() -> void:
	preview_dic.clear()
	for child in get_children():
		child.queue_free()


func remove_preview_by_camp(camp: Global.Camp) -> void:
	for pos in preview_dic.keys():
		if preview_dic[pos].camp == camp:
			preview_dic[pos].queue_free()
			preview_dic.erase(pos)


func show_array(camp: Global.Camp, positions: Array, height_offset: float = 0.0) -> void:
	for pos in positions:
		if map_to_local(pos) == Vector3.INF:
			continue
		var instance = move_preview_scene.instantiate()
		add_child(instance)
		instance.global_position = map_to_local(pos) + Vector3(0, height_offset, 0)
		preview_dic[pos] = instance
		instance.set_camp(camp)


func show_range(camp: Global.Camp, distances: Dictionary, height_offset: float = 0.0) -> void:
	for pos in distances:
		var instance = move_preview_scene.instantiate()
		add_child(instance)
		instance.global_position = map_to_local(pos) + Vector3(0, height_offset, 0)
		preview_dic[pos] = instance
		instance.set_camp(camp)


func show_path(path: Array) -> void:
	for pos in preview_dic:
		if pos in path:
			preview_dic[pos].set_path_sprite(_get_path_texture(pos, path))
		else:
			preview_dic[pos].set_path_sprite(null)


func _get_path_texture(pos: Vector2i, path: Array) -> Texture2D:
	var connections = 0
	var index: int = path.find(pos)
	for i in range(4):
		var neighbor_pos = pos + NEIGHBOR_OFFSETS[i]
		var neighbor_index = path.find(neighbor_pos)
		if neighbor_pos in path and abs(neighbor_index - index) == 1:
			connections |= 1 << i

	var results = path_resources.filter(func(res): return res.connections == connections)
	if results.is_empty():
		return null

	return results[0].texture
