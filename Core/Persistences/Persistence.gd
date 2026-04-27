extends Node


@export var data: SaveData
@export_group("Default Config")
@export var master_volume: float = 1.0
@export var bgm_volume: float = 1.0
@export var sfx_volume: float = 1.0
@export var ui_volume: float = 1.0
@export var fullscreen: bool = true
@export var language: int = 0
@export var resolution: Vector2i = Vector2i(1280, 720)

var config: ConfigFile = ConfigFile.new()
var config_path: String = "user://settings.cfg"


func save_data():
	get_tree().call_group("Persist", "save_data")
	data.save_to_disk()


func load_data():
	get_tree().call_group("Persist", "load_data")


func save_config():
	config.save(config_path)


func load_config():
	var err = config.load(config_path)
	if err != OK:
		# 預設設定
		config.set_value("audio", "Master", master_volume)
		config.set_value("audio", "BGM", bgm_volume)
		config.set_value("audio", "SFX", sfx_volume)
		config.set_value("audio", "UI", ui_volume)
		config.set_value("video", "fullscreen", fullscreen)
		config.set_value("video", "language", language)
		config.set_value("video", "resolution", resolution)
		save_config()

	# 讀取音量設定
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), config.get_value("audio", "Master", master_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), config.get_value("audio", "BGM", bgm_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), config.get_value("audio", "SFX", sfx_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("UI"), config.get_value("audio", "UI", ui_volume))

	# 讀取全螢幕設定
	if config.get_value("video", "fullscreen", fullscreen):
		get_window().mode = Window.MODE_FULLSCREEN
	else:
		get_window().mode = Window.MODE_WINDOWED

	# 讀取語言
	var lang_index: int = config.get_value("video", "language", language)
	TranslationServer.set_locale(Global.Languages[lang_index])
	# 讀取解析度設定
	get_viewport().size = config.get_value("video", "resolution", resolution)
	DisplayServer.window_set_size(get_viewport().size)


func _ready() -> void:
	load_config()

	if not OS.is_debug_build():
		$CanvasLayer.hide()
