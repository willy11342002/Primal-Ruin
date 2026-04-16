class_name Relationship
extends Resource


const affinity_levels: Dictionary = {
	0: "Stranger",
	30: "Acquaintance",
	60: "Friend",
	90: "BestFriend"
}

@export var character_id: String
@export var character_display_name: String
@export var character_portrait: Texture2D
@export_multiline var character_description: String

@export var affinity: int = 0
@export var is_met: bool = false

var affinity_level: String:
	get:
		for threshold in affinity_levels.keys():
			if affinity < threshold:
				return affinity_levels[threshold]
		return affinity_levels[affinity_levels.keys().max()]


func _init(_character_id: String) -> void:
	character_id = _character_id
