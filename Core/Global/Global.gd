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

@onready var music_manager: AudioStreamPlayer = $MusicManager
