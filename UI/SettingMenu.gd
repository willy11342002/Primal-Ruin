extends Node


@export_file_path("*.tscn") var back_scene_path: String


func _ready() -> void:
	%FullScreen.button_pressed = Persistence.config.get_value("video", "fullscreen")

	for lang in Global.Languages:
		%Language.add_item(lang)

	var lang_index: int = Persistence.config.get_value('video', 'language')
	%Language.select(lang_index)

	_load_volume("Master")
	_load_volume("BGM")
	_load_volume("SFX")
	_load_volume("UI")


func _on_back_button_up() -> void:
	SceneLoader.load_scene(back_scene_path)


func _on_language_item_selected(index: int) -> void:
	var lang_key: String = %Language.get_item_text(index)
	TranslationServer.set_locale(lang_key)
	Persistence.config.set_value("video", "language", index)


func _load_volume(bus_name: String) -> void:
	var node: HSlider = get_node("%" + bus_name + "Slider")
	node.value = db_to_linear(Persistence.config.get_value("audio", bus_name))
	print(node.name, db_to_linear(Persistence.config.get_value("audio", bus_name)))


func _save_volume(bus_name: String, value: float) -> void:
	value = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), value)
	Persistence.config.set_value("audio", bus_name, value)


func _on_master_slider_value_changed(value: float) -> void:
	_save_volume("Master", value)


func _on_bgm_slider_value_changed(value: float) -> void:
	_save_volume("BGM", value)


func _on_sfx_slider_value_changed(value: float) -> void:
	_save_volume("SFX", value)


func _on_ui_silder_value_changed(value: float) -> void:
	_save_volume("UI", value)


func _on_full_screen_toggled(toggled_on: bool) -> void:
	var win: Window = get_window()
	if toggled_on:
		win.mode = Window.MODE_FULLSCREEN
	else:
		win.mode = Window.MODE_WINDOWED
	Persistence.config.set_value("video", "fullscreen", toggled_on)


func _on_save_button_up() -> void:
	Persistence.save_config()
	SceneLoader.load_scene(back_scene_path)
