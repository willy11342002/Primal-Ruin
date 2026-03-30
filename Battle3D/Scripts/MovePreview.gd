extends Node3D


@export var path_sprite: Sprite3D
@export var surface_sprite: Sprite3D

func set_camp(camp: Global.Camp) -> void:
	surface_sprite.frame = int(camp)


func set_path_sprite(texture: Texture2D) -> void:
	path_sprite.texture = texture
