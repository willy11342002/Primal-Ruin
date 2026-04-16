extends Node


@export_file_path("*.tscn")
var start_scene_path: String
@export_file_path("*.tscn")
var load_scene_path: String
@export_file_path("*.tscn")
var setting_scene_path: String
@export_file_path("*.tscn")
var credit_scene_path: String


func _on_start_button_up() -> void:
	SceneLoader.load_scene(start_scene_path)


func _on_load_button_up() -> void:
	SceneLoader.load_scene(load_scene_path)


func _on_setting_button_up() -> void:
	SceneLoader.load_scene(setting_scene_path)


func _on_credit_button_up() -> void:
	SceneLoader.load_scene(credit_scene_path)


func _on_exit_button_up() -> void:
	get_tree().quit()
