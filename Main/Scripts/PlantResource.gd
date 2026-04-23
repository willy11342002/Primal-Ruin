class_name PlantResource
extends Resource


@export var name: String
@export var source_id: int
@export var atlas_coords: Vector2i
@export var growth_time: Array[int]

@export var current_days: int = 0
@export var current_stage: int = -1


func grow() -> bool:
	current_days += 1
	var index: int = current_stage + 1
	if index >= growth_time.size():
		return false
	if current_days >= growth_time[index]:
		current_stage = index
		current_days = 0
		return true
	return false
