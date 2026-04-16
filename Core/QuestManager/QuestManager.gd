extends Node


@export var quests: Array[Quest] = []


func save_data() -> void:
	Persistence.data.quests = quests.duplicate(true)


func load_data() -> void:
	quests = Persistence.data.quests.duplicate(true)


func get_quest_by_npc(character_id: String) -> Quest:
	for quest in quests:
		if quest.quest_giver_id == character_id:
			return quest
		if quest.quest_receiver_id == character_id:
			return quest
		if quest.quest_quest_npcs.has(character_id):
			return quest
	return
