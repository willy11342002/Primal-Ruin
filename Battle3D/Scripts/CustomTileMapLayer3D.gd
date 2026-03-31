@tool
class_name CustomTileMapLayer3D
extends TileMapLayer3D


var _xz_tile_positions: Dictionary = {}
var rect: Rect2i


func _ready() -> void:
	super._ready()
	if not Engine.is_editor_hint():
		for child in get_children():
			if child is SpawnPoint:
				child.hide()
	for i in _tile_positions.size():
		var grid_position: Vector3 = _tile_positions[i]
		if fmod(grid_position.x, 1.0) != 0 or fmod(grid_position.z, 1.0) != 0:
			continue
		var grid_xz: Vector2i = Vector2i(int(grid_position.x), int(grid_position.z))
		if not _xz_tile_positions.has(grid_xz):
			_xz_tile_positions[grid_xz] = [grid_position]
		else:
			_xz_tile_positions[grid_xz].append(grid_position)

	rect = get_map_boundary()


func get_map_boundary() -> Rect2i:
	if _xz_tile_positions.is_empty():
		return Rect2i()

	# 取得所有的 keys (Vector2i)
	var keys = _xz_tile_positions.keys()
	
	# 初始化極值
	var first_key = keys[0]
	var min_x = first_key.x
	var max_x = first_key.x
	var min_y = first_key.y # 這裡的 y 對應 Vector2i 的 Z 軸
	var max_y = first_key.y

	# 遍歷所有座標找出邊界
	for pos in keys:
		if pos.x < min_x: min_x = pos.x
		if pos.x > max_x: max_x = pos.x
		if pos.y < min_y: min_y = pos.y
		if pos.y > max_y: max_y = pos.y

	# Rect2i(起始點X, 起始點Y, 寬度, 高度)
	var width = max_x - min_x
	var height = max_y - min_y
	
	return Rect2i(min_x, min_y, width, height)


func get_heightest_tile_at(xz: Vector2i) -> Vector3:
	if not _xz_tile_positions.has(xz):
		return -Vector3.INF
	var tiles: Array = _xz_tile_positions[xz]
	var best: Vector3 = tiles.reduce(
		func(_best, _curr):
			return _best if _best.y > _curr.y else _curr,
		-Vector3.INF
	)
	return best


func get_top_tile_data(xz: Vector2i) -> Dictionary:
	var best: Vector3 = get_heightest_tile_at(xz)
	var best_index: int = _tile_positions.find(best)
	if best_index < 0:
		return {}

	var data: Dictionary = get_tile_data_at(best_index)
	return data


## 世界座標轉INDEX座標
func world_to_grid(world_pos: Vector3) -> Vector3:
	var grid_position: Vector3 = world_pos / grid_size - 0.5 * Vector3.ONE
	grid_position.x = roundi(grid_position.x)
	grid_position.y = roundi(grid_position.y)
	grid_position.z = roundi(grid_position.z)
	grid_position.y -= 0.5 # 不知為何grid_position的y值是從-0.5開始
	return grid_position


## INDEX座標轉地圖座標
func grid_to_map(grid_position: Vector3) -> Vector2i:
	return Vector2i(int(grid_position.x), int(grid_position.z))


## 地圖座標轉INDEX座標
func map_to_grid(map_pos: Vector2i, height: float = -0.5) -> Vector3:
	return Vector3(map_pos.x, height, map_pos.y)


## INDEX座標轉世界座標
func grid_to_world(grid_position: Vector3) -> Vector3:
	grid_position.y += 0.5 # 補回world_to_grid中減去的0.5
	grid_position += 0.5 * Vector3.ONE
	return grid_position * grid_size


## 世界座標轉地圖座標, 損失Y軸資訊
func world_to_map(world_pos: Vector3) -> Vector2i:
	return grid_to_map(world_to_grid(world_pos))


func map_to_world(map_pos: Vector2i) -> Vector3:
	var height: float = get_map_height(map_pos)
	if height == -INF: return Vector3.INF
	
	return grid_to_world(map_to_grid(map_pos, height))


func get_map_height(map_pos: Vector2i) -> float:
	var top_tile: Dictionary = get_top_tile_data(map_pos)
	if top_tile.is_empty():
		return -INF

	var height: float = 0.0
	if top_tile["mesh_mode"] == GlobalConstants.MeshMode.BOX_MESH \
	or top_tile["mesh_mode"] == GlobalConstants.MeshMode.PRISM_MESH:
		height = -0.5 + top_tile["grid_position"].y + top_tile["depth_scale"]
	return height


func get_camp_spawn_points(camp: Global.Camp) -> Array:
	var points: Array = []
	for child in get_children():
		if child is SpawnPoint:
			if child.camp == camp:
				var point = world_to_map(child.global_position)
				points.append(point)
	return points
