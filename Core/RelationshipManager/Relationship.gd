class_name Relationship
extends Resource


const affinity_levels: Dictionary = {
	0: "陌生人",
	30: "點頭之交",
	60: "好友",
	90: "生死之交"
}

@export var character_id: String
@export var display_name: String
@export var portrait: Texture2D
@export_multiline var description: String

@export var affinity: int = 0
@export var is_met: bool = false


func _init(_character_id: String) -> void:
	character_id = _character_id
