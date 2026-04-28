extends Node


enum Camp {
	PLAYER,
	ENEMY,
	NEUTRAL,
	ALLY
}

const CampColor: Dictionary = {
	Camp.PLAYER: Color.GREEN,
	Camp.ENEMY: Color.RED,
	Camp.NEUTRAL: Color.OLD_LACE,
	Camp.ALLY: Color.PALE_GREEN,
}


const Languages: Array = [
	"en",
	"zh_TW",
]

@warning_ignore("unused_signal") signal pause_player_input(paused: bool)


func set_game_pause() -> void:
	get_tree().paused = true


func set_game_resume() -> void:
	get_tree().paused = false


func any_signal(signals: Array[Signal]):
	var winner = {"sig": null}
	
	# 建立一個處理函數，誰先到就把自己塞進結果裡
	var resolver = func(s: Signal):
		if winner.sig == null:
			winner.sig = s

	# 連接所有訊號
	for s in signals:
		# 使用 bind(s) 把訊號自己傳進去，方便後續比對
		s.connect(resolver.bind(s), CONNECT_ONE_SHOT)

	# 迴圈等待直到有人贏得比賽
	while winner.sig == null:
		await get_tree().process_frame
		
	# 回傳那個贏家訊號
	return winner.sig
