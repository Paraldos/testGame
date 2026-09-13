extends CanvasLayer

const ANIMATION_DURATION = 0.6

@onready var background: ColorRect

var modal: Modal = null
var replacing_modal := false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _add_background():
	background = ColorRect.new()
	add_child(background)
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.modulate.a = 0.0

# ================================================== open / close logic
func open_modal(modal_scene: PackedScene, properties: Dictionary = { }) -> void:
	if modal == null:
		get_tree().paused = true
		_fade_background(1.0)
	else:
		replacing_modal = true
		await modal.close()
	modal = modal_scene.instantiate() as Modal
	for property in properties:
		modal.set(property, properties[property])
	modal.tree_exited.connect(_on_tree_exited.bind(modal))
	get_tree().current_scene.add_child(modal)
	replacing_modal = false

func _on_tree_exited(m: Modal) -> void:
	if modal != m:
		return
	modal = null
	if replacing_modal:
		return
	var tree := get_tree()
	if tree == null:
		return
	_fade_background(0.0)
	tree.paused = false

func close_current_modal():
	if modal == null:
		return
	modal.close()

# ================================================== background
func _fade_background(target_alpha: float) -> void:
	var t := create_tween()
	t.tween_property(background, "modulate:a", target_alpha, ANIMATION_DURATION)
	await t.finished
