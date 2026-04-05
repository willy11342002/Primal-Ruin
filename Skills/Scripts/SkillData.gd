class_name SkillData
extends Resource


@export var name: String
@export var icon: Texture2D
@export var description: String

## 技能消耗
@export var cost: SkillCost

## 施放邏輯, 用來決定可被施放格子
@export var cast_rule: CastRule
## 波及邏輯, 用來決定造成效果的格子
@export var impact_rules: Array[ImpactRule]
## 能量傳遞, 用來決定如何通過路徑
@export var emitter_rule: EmitterRule


func costs_enough(unit: CombatUnit) -> bool:
	var property_name: String = SkillCost.Type.keys()[cost.type].to_lower()
	var property = unit.unit_data.get(property_name)
	if property == null:
		return false
	if property < cost.amount:
		return false
	return true


func costs_pay(unit: CombatUnit) -> void:
	var property_name: String = SkillCost.Type.keys()[cost.type].to_lower()
	var property = unit.unit_data.get(property_name)
	if property == null:
		return
	unit.unit_data.set_property(property_name, property - cost.amount)


func get_castable_positions(unit_map_pos: Vector2i) -> Array:
	var positions := cast_rule.get_valid_positions()
	return positions.map(func(pos): return pos + unit_map_pos)


func get_impact_positions(unit_map_pos: Vector2i, target_map_pos: Vector2i) -> Array:
	# 初始方向：從施法者指向第一個目標點
	var initial_direction := (target_map_pos - unit_map_pos)
	if initial_direction == Vector2i.ZERO: initial_direction = Vector2i.UP 
	initial_direction = Vector2i(sign(initial_direction.x), sign(initial_direction.y))

	var results: Array[Array] = []
	
	# 第一層 (Step 0)
	results.append([target_map_pos])
	
	# current_sources 存儲的是下一層的「發射源資訊」
	# 格式: {"pos": Vector2i, "dir": Vector2i}
	var current_sources: Array[Dictionary] = [
		{"pos": target_map_pos, "dir": initial_direction}
	]

	# 依照碎片鏈條逐層處理
	for ext in impact_rules:
		var next_layer_cells: Array[Vector2i] = []
		var next_sources: Array[Dictionary] = []
		
		for source in current_sources:
			# 關鍵：根據「進入這一格的方向」來計算「下一格的方向」
			var offsets = ext.get_valid_positions(source.dir)
			
			for offset in offsets:
				var next_pos = source.pos + offset
				var next_dir = offset.sign() # 這次移動的方向，變成下一層的基礎方向
				
				# 記錄座標用於回傳顯示
				if not next_pos in next_layer_cells:
					next_layer_cells.append(next_pos)
				
				# 記錄資訊供下一層碎片使用
				next_sources.append({"pos": next_pos, "dir": next_dir})
		
		if next_layer_cells.is_empty():
			break
			
		results.append(next_layer_cells)
		current_sources = next_sources

	return results
