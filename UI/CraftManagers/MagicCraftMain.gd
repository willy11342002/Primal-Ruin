extends Control


@export_file_path("*.tscn") var cancel_scene_path: String
@export var total_fragments: Array[SkillFragment]

signal display_fragments_updated

var display_fragments: Array[SkillFragment]
var inside_body_container: bool = false
var dragging_data: SkillFragment
var skill_context: SkillContext
var skill_data: SkillData


func _ready() -> void:
	# total_fragments = Persistence.data.fragments.duplicate()
	display_fragments = total_fragments.duplicate()
	skill_data = SkillData.new()
	skill_context = SkillContext.new()
	%SlotContainer.setup(self)
	%BodyContainer.setup(self)
	%PreviewContainer.setup(self)
	_update_skill_context()


func _input(event: InputEvent) -> void:
	if dragging_data and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			_handle_drag_end()


func _handle_drag_end() -> void:
	var mouse_position = get_global_mouse_position()
	if %BodyContainer.global_position.distance_to(mouse_position) < 200:
		_confirm_add_fragment(dragging_data)
	else:
		_cancel_add_fragment(dragging_data)

	dragging_data = null
	_update_skill_context()


func _confirm_add_fragment(data: SkillFragment) -> void:
	skill_data.fragments.append(data)
	%PreviewContainer.remove_preview()
	%BodyContainer.add_body(data)
	

func _cancel_add_fragment(data: SkillFragment) -> void:
	%SlotContainer.display_fragments.append(data)
	%PreviewContainer.remove_preview()
	display_fragments_updated.emit()


func _on_start_drag(data: SkillFragment) -> void:
	%PreviewContainer.add_preview(data)
	dragging_data = data


func _add_description(msg: String) -> Label:
	var label = Label.new()
	label.text = msg
	return label


func _update_skill_context() -> void:
	skill_context = SkillContext.new()
	skill_context.setup(skill_data)

	%ContextBaseDamage.text = str(skill_context.base_damage)
	%ContextDamageMultiplier.text = str(skill_context.damage_multiplier)
	%ContextFinalDamage.text = str(skill_context.final_damage)

	for child in %ContextEffects.get_children():
		child.queue_free()
	for cost in skill_context.costs:
		var msg = tr("p_" + cost) + tr("p_Cost") + ": " + str(skill_context.costs[cost])
		%ContextEffects.add_child(_add_description(msg))

	%CastPreview.set_preview(skill_data.get_cast_positions(Vector2i.ZERO))
	
	var preview_impact_positions: Array = []
	var impact_positions: Array = skill_data.get_impact_positions(Vector2i.LEFT, Vector2i.ZERO)
	for layer in impact_positions:
		for pos in layer:
			if pos not in preview_impact_positions:
				preview_impact_positions.append(pos)
	%ImpactPreview.set_preview(preview_impact_positions)


func show_fragment_detail(data: SkillFragment) -> void:
	%TilePreview.hide()
	%FragmentDetail.show()
	
	%FragmentDetailName.text = data.name
	%FragmentDetailSpace.text = str(data.radius)

	# 展示效果描述
	for child in %FragmentDetailEffects.get_children():
		child.queue_free()
	if data.cost:
		%FragmentDetailEffects.add_child(_add_description(data.cost.description()))
	for effect in data.effects:
		%FragmentDetailEffects.add_child(_add_description(effect.description()))
	if data.impact_rule:
		%FragmentDetailEffects.add_child(_add_description(data.impact_rule.description()))


func close_fragment_detail() -> void:
	%TilePreview.show()
	%FragmentDetail.hide()


func _on_confirm_button_up() -> void:
	for fragment in skill_data.fragments:
		Persistence.data.fragments.erase(fragment)
	Persistence.skills.append(skill_data)
	Persistence.save_to_disk()
	SceneLoader.load_scene(cancel_scene_path)


func _on_cancel_button_up() -> void:
	SceneLoader.load_scene(cancel_scene_path)


func _on_body_container_mouse_entered() -> void:
	inside_body_container = true


func _on_body_container_mouse_exited() -> void:
	inside_body_container = false
