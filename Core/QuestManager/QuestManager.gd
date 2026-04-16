extends Node


@export var quests: Array[Quest] = []


func save_data() -> void:
	Persistence.data.quests = quests.duplicate(true)


func load_data() -> void:
	quests = Persistence.data.quests.duplicate(true)
