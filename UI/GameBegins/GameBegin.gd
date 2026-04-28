extends Node


@export var dialogue: DialogueResource


func _ready() -> void:
	%LineEdit.grab_focus()


func submit_user_name() -> void:
	Persistence.data.player_name = %LineEdit.text
	Persistence.save_data()
	
	DialogueManager.show_dialogue_balloon(dialogue, 'start')


func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text != "":
		submit_user_name()


func _on_button_button_up() -> void:
	if %LineEdit.text != "":
		submit_user_name()
