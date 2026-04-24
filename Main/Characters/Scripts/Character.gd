extends CharacterBody2D


var moving: bool = false: set = set_moveing


func set_moveing(is_moving: bool) -> void:
	moving = is_moving


func set_item(item: ItemResource) -> void:
	if item:
		%ActionComponent.action = item.action
		%ActionComponent.data = item.data
	else:
		%ActionComponent.action = "interact"
		%ActionComponent.data = null


func _ready() -> void:
	%MoveComponent.input_direction_changed.connect(_on_input_direction_changed)
	%MoveComponent.moving_state_changed.connect(set_moveing)


func _on_input_direction_changed(direction: Vector2) -> void:
	if has_node("%AnimationTree"):
		%AnimationTree.set("parameters/Idle/blend_position", direction)
		%AnimationTree.set("parameters/Run/blend_position", direction)
