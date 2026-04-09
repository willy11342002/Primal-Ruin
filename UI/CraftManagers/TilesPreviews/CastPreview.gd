extends TileMapLayer


@export var cast_atlas: Vector2i = Vector2i(2, 0)
@export var caster_atlas: Vector2i = Vector2i(0, 1)


func set_preview(positions: Array) -> void:
	clear()
	for pos in positions:
		if pos == Vector2i.ZERO:
			set_cell(pos, 0, caster_atlas)
			continue
		set_cell(pos, 0, cast_atlas)
