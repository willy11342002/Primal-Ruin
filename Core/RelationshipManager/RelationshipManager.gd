extends Node


var relationships: Dictionary = {}


func save_data() -> void:
	Persistence.data.relationships = relationships.duplicate(true)


func load_data() -> void:
	relationships = Persistence.data.relationships.duplicate(true)


## 增加好感度
func add_affinity(character_id: String, amount: int) -> void:
	_ensure_character_exists(character_id)
	var new_amount: int = relationships[character_id].affinity + amount
	relationships[character_id].affinity = clamp(new_amount, 0, 100)


## 標記為已遇見
func mark_as_met(character_id: String) -> void:
	_ensure_character_exists(character_id)
	relationships[character_id].is_met = true


## 取得好感度數值
func get_affinity(character_id: String) -> int:
	return relationships.get(character_id, {"affinity": 0}).affinity


## 檢查是否見過面
func has_met(character_id: String) -> bool:
	return relationships.get(character_id, {"is_met": false}).is_met


func _ensure_character_exists(character_id: String) -> void:
	if not relationships.has(character_id):
		relationships[character_id] = Relationship.new(character_id)
