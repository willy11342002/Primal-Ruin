extends Node


@export var dialogue: DialogueResource
@export_file_path("*.tscn") var next_scene: String
@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	%LineEdit.grab_focus()


func submit_user_name() -> void:
	Persistence.data.player_name = %LineEdit.text
	Persistence.save_data()
	
	var balloon =DialogueManager.show_example_dialogue_balloon(dialogue, 'start', [self])
	balloon.tree_exited.connect(_on_dialogue_finished)


func _on_dialogue_finished() -> void:
	SceneLoader.load_scene(next_scene)


func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text != "":
		submit_user_name()


func _on_button_button_up() -> void:
	if %LineEdit.text != "":
		submit_user_name()


func play_animation(animation_name: String) -> void:
	if anim_player.has_animation(animation_name):
		anim_player.play(animation_name)
		await anim_player.animation_finished
