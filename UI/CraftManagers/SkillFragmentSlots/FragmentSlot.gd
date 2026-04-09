extends Button


@export var radius: float = 60.0

signal hovered(fragment)
signal drag_started(fragment)
signal unhovered

var data: SkillFragment


func setup(_data) -> void:
	data = _data
	radius = data.radius
	text = data.name
	icon = data.icon


func _on_button_down() -> void:
	drag_started.emit(data)
	queue_free()


func _on_mouse_entered() -> void:
	hovered.emit(data)


func _on_mouse_exited() -> void:
	unhovered.emit()
