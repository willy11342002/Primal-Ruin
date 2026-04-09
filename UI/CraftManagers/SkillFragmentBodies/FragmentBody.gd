extends PathFollow2D


@export var chape: CollisionShape2D
@export var progress_speed: float = 5.0
@onready var shield_mat: ShaderMaterial = $ShieldRimSprite.material

var data: SkillFragment
var is_hovered: bool = false

signal drag_started(data: SkillFragment)
signal hovered(data: SkillFragment)
signal unhovered


func setup(_data: SkillFragment) -> void:
	data = _data
	$IconSprite.texture = data.icon
	chape.shape.radius = data.radius

	# 根據 Resource 半徑調整視覺
	var visual_scale = (data.radius * 2.0) / 128.0
	$BlackHoleSprite.scale = Vector2.ONE * visual_scale
	$ShieldRimSprite.scale = Vector2.ONE * visual_scale


	shield_mat.set_shader_parameter("line_color", Color(0.953, 0.537, 1.0))
	shield_mat.set_shader_parameter("actual_contacts", 5)
	shield_mat.set_shader_parameter("hit_points", [0.0, 0.0, 0.0, 0.0, 0.0])
	shield_mat.set_shader_parameter("hit_intensities", [0.0, 0.0, 0.0, 0.0, 0.0])


func _on_area_2d_mouse_entered() -> void:
	is_hovered = true
	hovered.emit(data)


func _on_area_2d_mouse_exited() -> void:
	is_hovered = false
	unhovered.emit()


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			drag_started.emit(data)
			queue_free()
