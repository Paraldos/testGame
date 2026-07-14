extends Area2D

@onready var selection_shape: CollisionShape2D = %SelectionShape
@onready var selection_visual: Line2D = %SelectionVisual
var start_point

func _ready() -> void:
	monitoring = false
	selection_visual.visible = false

func _unhandled_input(event: InputEvent) -> void:
	_left_click(event)

func _left_click(event: InputEvent):
	if event is not InputEventMouseButton: return
	if event.button_index != MOUSE_BUTTON_LEFT: return
	if event.pressed:
		pass
