class_name Machine extends Node


@export var initial_state: State
@export_enum("OFF", "ON") var mode: int = 1
@onready var _target_node: Node = get_parent() as Node

signal state_changed(new_state: String, context: Dictionary)

var _map: Dictionary = {}
var current: State


func _ready() -> void:
	if not mode:
		return
	if initial_state == null:
		return
	_init_states.call_deferred()


func _init_states():
	for child in get_children():
		if child is State:
			_map[child.name] = child as State
			child.target = _target_node
			child.state_machine = self
			child.init()

	current = initial_state
	current.enter()


func _unhandled_input(event: InputEvent) -> void:
	if mode and current:
		current.handle_input(event)


func _process(delta: float) -> void:
	if mode and current:
		current.process_update(delta)


func _physics_process(delta: float) -> void:
	if mode and current:
		current.physics_update(delta)


func translate_to(new_state: String, context: Dictionary = {}) -> void:
	if not mode:
		return
	if not _map.has(new_state):
		push_error("錯誤: 狀態機 %s 無法轉換到未知狀態 [%s]" % [self.name, new_state])
		return

	current.exit()
	current = _map[new_state]
	current.enter(context)

	state_changed.emit(new_state)
