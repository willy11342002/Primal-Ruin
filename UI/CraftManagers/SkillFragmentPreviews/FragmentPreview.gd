extends RigidBody2D


@export var max_radius: float = 10.0
@export var radius: float = 16.0
@export var self_gravity: float = 3.0
@export var drag_force: float = 20.0

@onready var shield_mat: ShaderMaterial = $ShieldRimSprite.material

var data: SkillFragment

var direction: Vector2 = Vector2.ZERO
var is_hovered: bool = true
var target_intensity: float = 0.0
var current_intensity: float = 0.0

signal hovered(data: SkillFragment)
signal unhovered


func setup(_data: SkillFragment) -> void:
	data = _data
	$IconSprite.texture = data.icon
	$CollisionShape2D.shape.radius = data.radius
	
	# 根據 Resource 半徑調整視覺
	var visual_scale = (data.radius * 2.0) / 128.0
	$BlackHoleSprite.scale = Vector2.ONE * visual_scale
	$ShieldRimSprite.scale = Vector2.ONE * visual_scale

	shield_mat.set_shader_parameter("line_color", Color(0.953, 0.537, 1.0))
	shield_mat.set_shader_parameter("actual_contacts", 5)
	shield_mat.set_shader_parameter("hit_points", [0.0, 0.0, 0.0, 0.0, 0.0])
	shield_mat.set_shader_parameter("hit_intensities", [0.0, 0.0, 0.0, 0.0, 0.0])


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var mouse_pos = get_global_mouse_position()
	var target_dir = state.transform.origin.direction_to(mouse_pos)
	var dist = state.transform.origin.distance_to(mouse_pos)
	
	state.apply_central_force(target_dir * dist * drag_force)
	state.linear_velocity *= 0.9 # 線性阻尼，手感更扎實


func _on_mouse_entered() -> void:
	is_hovered = true
	hovered.emit(data)


func _on_mouse_exited() -> void:
	is_hovered = false
	unhovered.emit()
