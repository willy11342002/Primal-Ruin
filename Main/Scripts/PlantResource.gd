class_name PlantResource
extends Resource


## 植物名稱
@export var name: String


## 圖集來源ID
@export var source_id: int

## 圖集起始座標
@export var atlas_coords: Vector2i

## 生長季節
@export_flags("Spring", "Summer", "Fall", "Winter")
var season: int

## 收穫農作物
@export var harvest: ItemResource

## 重複採收
@export var multiple_harvest: bool = false

## 成長時間表
## 單位為天，陣列長度為成長階段數
@export var growth_time: Array[int]

## 以下為運行時資料
@export_group("Runtime")
## 目前生長天數
## 當達到成長時間表中對應階段的天數時，升級到下一階段
@export var current_days: int = 0
## 目前成長階段
## 從0開始，當達到成長時間表中最後一個階段的天數時，不再升級
@export var current_stage: int = 0


func grow() -> bool:
	current_days += 1
	if current_stage >= growth_time.size():
		return false
	if current_days >= growth_time[current_stage]:
		current_stage += 1
		current_days = 0
		return true
	return false
