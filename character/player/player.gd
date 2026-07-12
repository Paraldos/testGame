extends Character

var path : PackedVector2Array

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:
		path = Grid.get_world_path(global_position, get_global_mouse_position())
	path_line.points = path
