extends CharacterBody3D


func _ready() -> void:
	%MoveComponent.input_direction_changed.connect(_on_input_direction_changed)


func _on_input_direction_changed(world_direction: Vector3) -> void:
	var direction: Vector2 = Vector2(world_direction.x, world_direction.z)
	%AnimationTree.set("parameters/BlendTree/BlendSpace2D/blend_position", direction)


func _physics_process(_delta: float) -> void:
	# 這裡只負責執行最終的移動，邏輯由組件更新 velocity
	move_and_slide()
