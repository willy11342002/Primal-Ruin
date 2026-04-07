extends Control


signal drag_started()
@export var radius: float = 60.0


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			drag_started.emit(self)
			self.hide()
