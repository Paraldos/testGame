extends TileMapLayer

var cell_size = Vector2(16,16)
var rect : Rect2i

func _ready() -> void:
	rect = get_used_rect()
	cell_size = Vector2(tile_set.tile_size) * scale
	Grid.setup(rect, cell_size, global_position)
