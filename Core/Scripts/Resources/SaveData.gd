class_name SaveData extends Resource


@export var player_name: String = ""
@export var hotkey_inventory: Array[InventorySlot]


@export_group("File Info")
@export var title: String = ""
@export var file_name: String = ""
@export var modified_time: int = 0


@export_group("CombatScene")
@export var player: UnitData
@export var active_team: Array[UnitData]
@export var skills: Array[SkillData] = []
@export var fragments: Array[SkillFragment] = []
@export var quests: Array[Quest] = []
@export var relationships: Dictionary = {}


func save_to_disk():
	ResourceSaver.save(self, self.file_name)
