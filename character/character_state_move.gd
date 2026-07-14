extends CharacterState

var path : Array[Vector2]
var line : Line2D
@export var idle_state : CharacterState

func enter():
	super()
	_add_line()
	step()

func exit():
	super()
	line.queue_free()

func _add_line():
	line = Line2D.new()
	line.points = path
	line.global_position = Grid._cell_size / 2
	line.width = 1.0
	Utils.paths.add_child(line)

func step() -> void:
	while not path.is_empty():
		var next_grid_position = path.pop_front()
		var move_tween = create_tween()
		move_tween.tween_property(
			character,
			"global_position",
			next_grid_position,
			character.move_duration
		)
		await move_tween.finished
	state_machine.change_state(idle_state)
