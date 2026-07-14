extends CharacterState

@export var idle_state : CharacterState
var path : Array[Vector2]
var line : Line2D
var is_moving := false

func enter():
	super()
	step()

func exit():
	super()
	line.queue_free()

func update_path(new_path : Array[Vector2]):
	path = new_path.duplicate()
	_add_line()

func _add_line():
	if line != null:
		line.queue_free()
	line = Line2D.new()
	line.points = path
	line.global_position = Grid._cell_size / 2
	line.width = 1.0
	Utils.paths.add_child(line)

func step() -> void:
	if is_moving: return
	is_moving = true
	while not path.is_empty():
		var next_grid_position = path.pop_front()
		if next_grid_position == character.global_position:
			continue
		var move_tween = create_tween()
		move_tween.tween_property(
			character,
			"global_position",
			next_grid_position,
			character.move_duration
		)
		await move_tween.finished
	is_moving = false
	state_machine.change_state(idle_state)
