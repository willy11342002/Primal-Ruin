class_name SaveData extends Resource


@export_group("File Info")
@export var title: String = ""
@export var file_name: String = ""
@export var modified_time: int = 0

@export var player_name: String = ""
@export var player: UnitData
@export var active_team: Array[UnitData]
@export var skills: Array[SkillData] = []
@export var fragments: Array[SkillFragment] = []
@export var quests: Array[Quest] = []


func save_to_disk():
	ResourceSaver.save(self, self.file_name)
