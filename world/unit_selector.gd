extends Area2D

@onready var selection_shape: CollisionShape2D = %SelectionShape
@onready var selection_visual: Line2D = %SelectionVisual
var _start_point : Vector2
var _end_point : Vector2
var is_selecting = false

func _ready() -> void:
	selection_visual.visible = false

func _process(_delta: float) -> void:
	if is_selecting: _draw_selector()

func _draw_selector():
	_end_point = get_global_mouse_position()
	var size := (_end_point - _start_point).abs()
	var center := (_start_point + _end_point) / 2.0
	var rectangle_shape := selection_shape.shape as RectangleShape2D
	var half_size := size / 2.0
	selection_shape.global_position = center
	selection_visual.position = center
	rectangle_shape.size = size
	selection_visual.points = PackedVector2Array([
		Vector2(-half_size.x, -half_size.y),
		Vector2( half_size.x, -half_size.y),
		Vector2( half_size.x,  half_size.y),
		Vector2(-half_size.x,  half_size.y),
		Vector2(-half_size.x, -half_size.y)
	])

func _unhandled_input(event: InputEvent) -> void:
	_left_click(event)

func _left_click(event: InputEvent):
	if event is not InputEventMouseButton: return
	if event.button_index != MOUSE_BUTTON_LEFT: return
	if event.pressed:
		_start_point = get_global_mouse_position()
		_end_point = _start_point
		is_selecting = true
		selection_visual.visible = true
	if event.is_released():
		_select_units()
		is_selecting = false
		selection_visual.visible = false

func _select_units():
	var overlapping_areas = get_overlapping_areas()
	for area in overlapping_areas:
		var char = area.get_parent()
		if char.has_method('select'):
			char.select()
