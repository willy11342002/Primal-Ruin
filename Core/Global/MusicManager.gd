@tool
extends AudioStreamPlayer


@export var is_shuffled: bool = false # 是否隨機播放
@export var playlist: Array[AudioStream] = []

var current_track_index: int = 0


func _ready() -> void:
	if not Engine.is_editor_hint() and autoplay:
		play_playlist(playlist, is_shuffled)


func _play_current_track():
	if current_track_index < playlist.size():
		stream = playlist[current_track_index]
		play()
		print("正在播放: ", stream.resource_path.get_file())


func _on_track_finished():
	current_track_index += 1
	
	# 如果播完了最後一首，回到第一首（循環播放）
	if current_track_index >= playlist.size():
		current_track_index = 0
		if is_shuffled:
			playlist.shuffle() # 每一輪循環重新打亂一次，更有隨機感
			
	_play_current_track()


func play_playlist(streams: Array[AudioStream], shuffle: bool = false):
	if streams.is_empty():
		return
		
	playlist = streams
	is_shuffled = shuffle
	current_track_index = 0
	
	if is_shuffled:
		playlist.shuffle() # 隨機打亂清單

	_play_current_track()


func next_track():
	_on_track_finished()


func stop_music():
	stop()
