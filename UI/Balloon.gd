extends DialogueManagerExampleBalloon


@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	%PlayerPortrait.modulate.a = 0
	%CharacterPortrait.modulate.a = 0


func set_player_portrait(texture: Texture2D) -> void:
	%PlayerPortrait.texture = texture


func set_character_portrait(texture: Texture2D) -> void:
	%CharacterPortrait.texture = texture


func show_player_portrait(wait: bool=true) -> void:
	anim_player.play("show_player_portrait")
	if wait:
		await anim_player.animation_finished


func hide_player_portrait(wait: bool=true) -> void:
	anim_player.play_backwards("show_player_portrait")
	if wait:
		await anim_player.animation_finished


func show_character_portrait(wait: bool=true) -> void:
	anim_player.play("show_character_portrait")
	if wait:
		await anim_player.animation_finished


func hide_character_portrait(wait: bool=true) -> void:
	anim_player.play_backwards("show_character_portrait")
	if wait:
		await anim_player.animation_finished
