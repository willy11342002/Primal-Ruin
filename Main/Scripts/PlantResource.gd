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
