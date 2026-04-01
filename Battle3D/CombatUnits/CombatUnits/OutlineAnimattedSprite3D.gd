extends AnimatedSprite3D


const outline_material = preload("uid://bybdwtbsalvc4")
const color_flash_material = preload("uid://b4agqr43pm1ru")

var outline_color: Color
var current_material


func _ready() -> void:
	frame_changed.connect(_on_frame_changed)
	call_deferred("_on_frame_changed")


func _on_frame_changed() -> void:
	var current_texture = sprite_frames.get_frame_texture(animation, frame)
	if material_override:
		material_override.set_shader_parameter("albedo_texture", current_texture)


func setup(unit_data: UnitData) -> void:
	sprite_frames = unit_data.get(name.to_lower() + "_animation")
	outline_color = Global.CampColor[unit_data.camp]


func flash_color(color: Variant) -> void:
	if color != null:
		if material_override == null or material_override.resource_name != "color_flash":
			var current_texture = sprite_frames.get_frame_texture(animation, frame)
			material_override = color_flash_material.duplicate()
			material_override.set_shader_parameter("albedo_texture", current_texture)
			material_override.set_shader_parameter("flash_color", color)
	else:
		material_override = null


func set_outline(enabled: bool) -> void:
	if enabled:
		if material_override == null or material_override.resource_name != "outline":
			var current_texture = sprite_frames.get_frame_texture(animation, frame)
			material_override = outline_material.duplicate()
			material_override.set_shader_parameter("albedo_texture", current_texture)
			material_override.set_shader_parameter("outline_color", outline_color)
			material_override.set_shader_parameter("outline_width", 1.0)
	else:
		material_override = null
