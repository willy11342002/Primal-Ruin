class_name Quest
extends Resource


enum Status {
	NOT_STARTED,
	IN_PROGRESS,
	COMPLETED,
	FAILED
}


@export var quest_name: String
@export var quest_desc: String
@export var quest_status: Status = Status.NOT_STARTED
## 任務發布者
@export var quest_giver_id: String
## 任務相關人員
@export var quest_quest_npcs: Array[String]
## 任務回報對象
@export var quest_receiver_id: String
