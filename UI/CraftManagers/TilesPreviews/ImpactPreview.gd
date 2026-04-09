extends TileMapLayer


@export var impact_atlas: Vector2i = Vector2i(1, 0)
@export var caster_atlas: Vector2i = Vector2i(0, 1)


func set_preview(positions: Array) -> void:
	clear()
	for pos in positions:
		if pos == Vector2i.ZERO:
			set_cell(pos, 0, caster_atlas)
			continue
		set_cell(pos, 0, impact_atlas)
