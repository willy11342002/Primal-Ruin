extends AnimatedSprite3D


const material = preload("uid://bybdwtbsalvc4")


func _ready() -> void:
	material_override = material.duplicate()
	frame_changed.connect(_on_frame_changed)
	call_deferred("_on_frame_changed")


func _on_frame_changed() -> void:
	var current_texture = sprite_frames.get_frame_texture(animation, frame)
	material_override.set_shader_parameter("albedo_texture", current_texture)


func setup(unit_data: UnitData) -> void:
	sprite_frames = unit_data.get(name.to_lower() + "_animation")
	material_override.set_shader_parameter("outline_color", Global.CampColor[unit_data.camp])


func set_outline(enabled: bool) -> void:
	var width := 1.0 if enabled else 0.0
	material_override.set_shader_parameter("outline_width", width)
