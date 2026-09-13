@tool
extends CanvasLayer
class_name Modal

enum Directions {
	TOP,
	BOTTOM,
	LEFT,
	RIGHT,
}

const ANIMATION_DURATION = 0.5

@export var opening_from := Directions.TOP
@export var closing_to := Directions.BOTTOM
var screen_width: Vector2
var opening_from_pos: Vector2
var closing_to_pos: Vector2

var content_container: Control
var pos_active := Vector2.ZERO
var is_closing := false

func _ready() -> void:
	_add_content_container()
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	screen_width = get_viewport().get_visible_rect().size
	opening_from_pos = _get_position_for_direction(opening_from)
	closing_to_pos = _get_position_for_direction(closing_to)
	open()

# ====================================== helper
func _add_content_container():
	content_container = Control.new()
	content_container.name = "ContentContainer"
	content_container.unique_name_in_owner = true

	add_child(content_container)
	content_container.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	if Engine.is_editor_hint():
		content_container.owner = get_tree().edited_scene_root

func _get_position_for_direction(direction: Directions) -> Vector2:
	match direction:
		Directions.TOP:
			return Vector2(0.0, -screen_width.y)
		Directions.BOTTOM:
			return Vector2(0.0, screen_width.y)
		Directions.LEFT:
			return Vector2(-screen_width.x, 0.0)
		Directions.RIGHT:
			return Vector2(screen_width.x, 0.0)
	return Vector2.ZERO

# ====================================== animation
func open():
	content_container.position = opening_from_pos
	await _move_content(Vector2.ZERO, Tween.EASE_OUT)

func close() -> void:
	if is_closing:
		return
	is_closing = true
	await _move_content(closing_to_pos, Tween.EASE_IN)
	queue_free()
	await tree_exited

func _move_content(target_pos: Vector2, ease_type: Tween.EaseType):
	var t := create_tween()
	t.set_trans(Tween.TRANS_BACK)
	t.set_ease(ease_type)
	t.tween_property(content_container, 'position', target_pos, ANIMATION_DURATION)
	await t.finished
