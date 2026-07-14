extends TileMapLayer

var cell_size = Vector2(16,16)
var rect : Rect2i

func _ready() -> void:
	_setup_grid()
	_add_obstacles_to_grid()

func _setup_grid():
	rect = get_used_rect()
	cell_size = Vector2(tile_set.tile_size) * scale
	Grid.setup(rect, cell_size, global_position)

func _add_obstacles_to_grid():
	Grid.set_cells_blocked(get_used_cells())
