@tool
extends GridUnit3D


@export var camp: Global.Camp: set = set_camp
@onready var sprite: Sprite3D = $Sprite3D


func set_camp(value) -> void:
	camp = value
	if not is_node_ready():
		call_deferred("set_camp", value)
		return
	sprite.modulate = Global.CampColor[camp]
