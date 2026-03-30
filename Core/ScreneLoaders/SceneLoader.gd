extends Node


signal progress_changed(progress)
signal load_finished

var loading_screen: PackedScene = preload("uid://cjtygfyip8sje")
var loaded_resource: PackedScene
var data_to_pass: Resource
var scene_path: String
var progress: Array = []
@export var use_sub_threads: bool = true


func _ready() -> void:
	set_process(false)


func load_scene(_scene_path: String, _data_to_pass: Resource = null) -> void:
	scene_path = _scene_path
	data_to_pass = _data_to_pass
	
	var new_load_screen: Node = loading_screen.instantiate()
	add_child(new_load_screen)
	progress_changed.connect(new_load_screen._on_progress_changed)
	load_finished.connect(new_load_screen._on_load_finished)

	await new_load_screen.loading_screen_ready

	start_load()


func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)


func _process(_delta: float) -> void:
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	progress_changed.emit(progress[0])
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			if data_to_pass and loaded_resource.has_method("setup"):
				loaded_resource.setup(data_to_pass)
			get_tree().change_scene_to_packed(loaded_resource)
			load_finished.emit()
