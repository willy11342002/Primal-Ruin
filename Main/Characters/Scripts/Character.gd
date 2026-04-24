extends CharacterBody2D


var moving: bool = false: set = set_moveing


func set_moveing(is_moving: bool) -> void:
	moving = is_moving


func set_item(node: Node) -> void:
	if node:
		%ActionComponent.node = node
	else:
		%ActionComponent.node = null


func _ready() -> void:
	%MoveComponent.input_direction_changed.connect(_on_input_direction_changed)
	%MoveComponent.moving_state_changed.connect(set_moveing)


func _on_input_direction_changed(direction: Vector2) -> void:
	if has_node("%AnimationTree"):
		%AnimationTree.set("parameters/Idle/blend_position", direction)
		%AnimationTree.set("parameters/Run/blend_position", direction)
