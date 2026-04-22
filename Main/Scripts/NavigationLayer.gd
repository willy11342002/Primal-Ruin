extends TileMapLayer


## 這裡放入所有需要被偵測的地景圖層
@export var base_layers: Array[TileMapLayer] = []

## 指定要填入的 Tile ID 與 Atlas 座標 (通常是一個全填滿導航多邊形的方塊)
@export var placeholder_source_id: int = 0
@export var placeholder_atlas_coords: Vector2i = Vector2i(0, 0)


func _ready() -> void:
	# 確保在場景準備好後延遲一幀執行，以防萬一底層還沒初始化完成
	generate_navigation_mask.call_deferred()


func generate_navigation_mask() -> void:
	# 1. 先清空目前這一層的所有方塊
	clear()
	
	# 2. 用一個字典（Dictionary）來儲存所有已經掃描到的座標，避免重複計算
	var combined_cells: Dictionary = {}
	
	# 3. 遍歷所有基礎圖層
	for layer in base_layers:
		if not layer:
			continue
			
		var used_cells = layer.get_used_cells()
		for cell in used_cells:
			# 將座標存入字典（Key 為座標，Value 為 true 即可）
			# 這裡不需要考慮多層疊加，只要該位置「有東西」就行
			combined_cells[cell] = true
	
	# 4. 在目前這一層填上導航用的 Placeholder
	for cell in combined_cells.keys():
		set_cell(cell, placeholder_source_id, placeholder_atlas_coords)
	
	# 💡 注意：TileMapLayer 的導航更新通常是自動的。
	# 但如果你發現導航網格沒出現，可以強制烘焙（如果父節點是 NavigationRegion2D）
	print("導航層生成完成，共計填充了 ", combined_cells.size(), " 個方格。")
