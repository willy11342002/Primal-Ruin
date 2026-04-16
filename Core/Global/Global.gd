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
