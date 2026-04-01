class_name RangeCastRule
extends CastRule


@export_range(0, 10, 1) var min_range: int = 0
@export_range(0, 10, 1) var max_range: int = 1


func get_valid_positions() -> Array:
	var positions = []
	var range_distances = NavServer.find_range(
		Vector2i.ZERO,
		max_range,
	)
	
	for pos in range_distances.keys():
		var dist = range_distances[pos]
		if dist >= min_range and dist <= max_range:
			positions.append(pos)

	return positions
