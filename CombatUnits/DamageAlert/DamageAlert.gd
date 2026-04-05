class_name DamageAlert
extends HBoxContainer


const heal_material: Material = preload("uid://bgd8hrasn8fk2")
const damage_material: Material = preload("uid://bby6uj8aemiaj")

@onready var unit: CombatUnit = get_parent() as CombatUnit
@export var number_scene: PackedScene
@export var interval: float = 0.065
@export var offset_3d := Vector3(0, 2.0, 0) 

var unit_data: UnitData
var current_health: int


func setup(_unit_data: UnitData) -> void:
	_clear_children()
	unit_data = _unit_data

	unit.update_requested.connect(_on_update_requested)
	current_health = unit_data.health


func _on_update_requested() -> void:
	var damage: int = unit_data.health - current_health
	if damage == 0: return
	
	_update_position()
	var str_damage = str(damage)
	current_health = unit_data.health
	if '-' in str_damage:
		material = damage_material
		_create_text(11)
		for t in range(1, len(str_damage)):
			_create_text(int(str_damage[t]))
			await get_tree().create_timer(0.2).timeout
	else:
		material = heal_material
		_create_text(10)
		for t in range(len(str_damage)):
			_create_text(int(str_damage[t]))
			await get_tree().create_timer(0.2).timeout

	await get_tree().create_timer(0.8).timeout
	_clear_children()



func _clear_children() -> void:
	for child in get_children():
		child.queue_free()


func _create_text(index: int) -> void:
	var node: Node = number_scene.instantiate()
	node.texture.region.position.x = 6 * index
	add_child(node)


func _update_position() -> void:
	# 1. 取得當前作用中的 3D 相機
	var camera := get_viewport().get_camera_3d()
	
	# 2. 檢查相機是否能看到目標 (避免目標在鏡頭後方時 UI 亂跳)
	if camera.is_position_behind(unit.global_position):
		visible = false
	else:
		visible = true
		# 3. 關鍵轉換：將 3D 世界座標轉為 2D 螢幕座標
		var screen_pos := camera.unproject_position(unit.global_position + offset_3d)
		
		# 4. 設定 UI 的位置
		# 注意：UI 的 position 是左上角，如果你希望數字置中，
		# 需要減去 HBoxContainer 寬度的一半
		global_position = screen_pos - (size / 2.0)
