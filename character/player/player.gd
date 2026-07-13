extends Character

var path : PackedVector2Array

func _physics_process(delta: float) -> void:
	super(delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventMouseButton: return
	if event.button_index != MOUSE_BUTTON_LEFT: return
	if event.pressed:
		path = Grid.get_world_path(global_position, get_global_mouse_position())
	path_line.points = path
