extends CharacterBody3D


@onready var interact_label = $InteractionLabel
@onready var interact_area = $InteractionArea
@export var character_id: String
@export var dialogue: DialogueResource

var player: CharacterBody3D
var is_player_in_range: bool = false


func _on_body_entered(body: Node3D) -> void:
	if dialogue == null: return
	if body.is_in_group("Player"):
		is_player_in_range = true
		interact_label.show()
		player = body


func _on_body_exited(body: Node3D) -> void:
	if dialogue == null: return
	if body.is_in_group("Player"):
		is_player_in_range = false
		interact_label.hide()
		player = null


func _input(event: InputEvent) -> void:
	if is_player_in_range and event.is_action_pressed("interact"):
		on_inreract()


func on_inreract(title: String = "") -> void:
	# 由劇情推動/事件觸發的對話會帶入 title 參數，優先顯示特定對話
	if title != "":
		DialogueManager.show_example_dialogue_balloon(dialogue, title)
		return

	# 檢查當前任務後顯示任務相關對話
	var quest = QuestManager.get_quest_by_npc(character_id)
	if quest != null:
		DialogueManager.show_example_dialogue_balloon(dialogue, quest.quest_name, [quest])
		return

	# 初次見面的對話內容
	if not RelationshipManager.has_met(character_id):
		DialogueManager.show_example_dialogue_balloon(dialogue, "first_met")
		RelationshipManager.mark_as_met(character_id)
		return

	# 根據好感度顯示日常對話
	var relationship = RelationshipManager.get_relationship(character_id)
	DialogueManager.show_example_dialogue_balloon(dialogue, relationship.affinity_level, [relationship])


func _ready() -> void:
	%MoveComponent.input_direction_changed.connect(_on_input_direction_changed)


func _on_input_direction_changed(world_direction: Vector3) -> void:
	var direction: Vector2 = Vector2(world_direction.x, world_direction.z)
	%AnimationTree.set("parameters/BlendTree/BlendSpace2D/blend_position", direction)


func _physics_process(_delta: float) -> void:
	# 這裡只負責執行最終的移動，邏輯由組件更新 velocity
	move_and_slide()
