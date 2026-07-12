extends TileMapLayer

var rect = Rect2i(0,0,3,3)
var cell_size = Vector2(16,16)
var world_origin = Vector2.ZERO

func _ready() -> void:
	Grid.setup(rect, cell_size * scale, world_origin)
