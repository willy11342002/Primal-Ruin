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
	
	# 2. 用一個字典（Dictionary）來儲存所有已經掃描到的座標，以及對應的 atlas 座標
	var combined_cells: Dictionary = {}
	
	# 3. 遍歷所有基礎圖層
	for layer in base_layers:
		var used_cells = layer.get_used_cells()
		for cell in used_cells:
			# 已經被更高層的地塊佔用，跳過
			if cell in combined_cells:
				continue
			# 讀取該 tile 的 custom_data "alternative_tile"
			# 若有設定則使用該值，否則退回預設 placeholder_atlas_coords
			var data: TileData = layer.get_cell_tile_data(cell)
			if data:
				var alt = data.get_custom_data("alternative_tile")
				if alt != -1:
					combined_cells[cell] = alt

				var under_cell = Vector2i(cell.x, cell.y + 1)
				var under = data.get_custom_data("alternative_under")
				if under_cell not in combined_cells:
					if under not in [null, -1]:
						combined_cells[under_cell] = under

	# 4. 在目前這一層填上對應的導航 Tile
	for cell in combined_cells.keys():
		set_cell(cell, placeholder_source_id, placeholder_atlas_coords, combined_cells[cell])
	
	# 💡 注意：TileMapLayer 的導航更新通常是自動的。
	# 但如果你發現導航網格沒出現，可以強制烘焙（如果父節點是 NavigationRegion2D）
	print("導航層生成完成，共計填充了 ", combined_cells.size(), " 個方格。")
