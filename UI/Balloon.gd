extends DialogueManagerExampleBalloon


@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	%PlayerPortrait.modulate.a = 0
	%CharacterPortrait.modulate.a = 0


func toggle_dialogue_panel(_visible: bool) -> void:
	%DialoguePanel.visible = _visible


func play_animation_backwards(animation_name: String, wait: bool = true) -> void:
	if anim_player.has_animation(animation_name):
		anim_player.play_backwards(animation_name)
		if wait:
			await anim_player.animation_finished


func play_animation(animation_name: String, wait: bool = true) -> void:
	if anim_player.has_animation(animation_name):
		anim_player.play(animation_name)
		if wait:
			await anim_player.animation_finished


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
