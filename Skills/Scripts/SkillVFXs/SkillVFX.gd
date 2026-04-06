class_name SkillVFX
extends Resource


@export var vfx_scene: PackedScene

## 等待多久開始進行下一個特效
## 設定為1時 等待此特效結束後才進行下一特效
## 設定小於1時 等待該秒數後進行下一特效
@export var wait_for_next: float = 0.0

## 特效生成位置偏移
@export var offset: Vector3 = Vector3.ZERO

## 特效旋轉角度
@export var rotation: Vector3 = Vector3.ZERO

## 移動路徑[br]
## CAST狀態傳入 施法者位置到目標施放位置的路徑[br]
## IMPACT狀態傳入 上一階層來源位置到當前階層目標位置的路徑[br]
@export var pass_path: Array = []
