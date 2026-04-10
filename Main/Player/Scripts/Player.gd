extends CharacterBody3D

@export var speed := 5.0
@export var jump_velocity := 4.5

# 取得重力設定 (從專案設定讀取)
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(_delta: float) -> void:
	# 這裡只負責執行最終的移動，邏輯由組件更新 velocity
	move_and_slide()
