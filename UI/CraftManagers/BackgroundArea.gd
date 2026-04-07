extends Area2D


@export var fragment_prefab: PackedScene # 你的 RigidBody2D 碎片場景

var draging_data
var dragging_preview: RigidBody2D = null

func _on_inventory_item_drag_started(_data):
	dragging_preview = fragment_prefab.instantiate()
	dragging_preview.radius = _data.radius
	draging_data = _data
	
	dragging_preview.prevent_boundary_limit = false
	dragging_preview.is_dragging = true
	
	add_child(dragging_preview)
	dragging_preview.global_position = get_global_mouse_position()
	

func _input(event):
	if dragging_preview and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			# 放開時：檢查是否在圓圈內
			if _is_inside_core(dragging_preview.global_position):
				_confirm_add_fragment(dragging_preview)
			else:
				_cancel_add_fragment(dragging_preview)
			dragging_preview = null


func _is_inside_core(pos: Vector2) -> bool:
	var dist = pos.distance_to(global_position)
	return dist < $CollisionShape2D.shape.radius


func _confirm_add_fragment(fragment: RigidBody2D) -> void:
	fragment.prevent_boundary_limit = true
	fragment.is_dragging = false
	
	draging_data.queue_free()
	print("碎片已成功組裝！")


func _cancel_add_fragment(fragment: RigidBody2D) -> void:
	fragment.queue_free()

	draging_data.show()
	print("取消置入，碎片已回收。")
