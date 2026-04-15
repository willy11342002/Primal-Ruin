extends NobodyWhoChat


var current_message_label: Control


func _ready() -> void:
	model_node = get_tree().get_first_node_in_group("Model")
	start_worker.call_deferred()


func _on_response_finished(_response: String) -> void:
	if current_message_label:
		current_message_label._on_response_finished(_response)
		current_message_label = null


func _on_response_updated(new_token: String) -> void:
	if current_message_label:
		current_message_label._on_response_updated(new_token)
