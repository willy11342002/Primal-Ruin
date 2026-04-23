extends Node


@export var nav_component: Node

## 每次行動之間的最短等待秒數
@export var wander_min_wait: float = 1.5
## 每次行動之間的最長等待秒數
@export var wander_max_wait: float = 4.0
## 隨機移動的最大半徑 (像素)
@export var wander_radius: float = 200.0
## 每次觸發時不移動的機率 (0.0 ~ 1.0)
@export var idle_chance: float = 0.3


func _ready() -> void:
	_schedule_next_wander()


func _schedule_next_wander() -> void:
	var wait_time: float = randf_range(wander_min_wait, wander_max_wait)
	await get_tree().create_timer(wait_time).timeout
	_do_wander()


func _do_wander() -> void:
	if randf() >= idle_chance and nav_component:
		var parent := get_parent() as Node2D
		if parent:
			var offset := Vector2(
				randf_range(-wander_radius, wander_radius),
				randf_range(-wander_radius, wander_radius)
			)
			nav_component.move_to(parent.global_position + offset)
	_schedule_next_wander()
