class_name LineCastRule
extends CastRule


@export_range(0, 10, 1) var min_range: int = 0
@export_range(0, 10, 1) var max_range: int = 1


func get_valid_positions() -> Array:
	var positions = []
	for direction in NavServer.NEIGHBOR_OFFSETS:
		for i in range(min_range, max_range + 1):
			positions.append(direction * i)
	return positions
