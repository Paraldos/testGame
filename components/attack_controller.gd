extends Node2D
class_name ActionController

@export_enum(
	"action_left_click",
	"action_right_click",
	"action_slot_1",
	"action_slot_2",
	"action_slot_3",
) var input_action: String = "action_left_click"
var cooldown_timer := Timer.new()

func _ready() -> void:
	cooldown_timer.one_shot = true
	add_child(cooldown_timer)

func _process(_delta: float) -> void:
	if not Input.is_action_pressed(input_action):
		return
	if not cooldown_timer.is_stopped():
		return
	var item := _get_item()
	if item == null:
		return
	var dir := global_position.direction_to(get_global_mouse_position())
	var pos := global_position + dir * 12.0
	item.use(pos, dir, get_tree().current_scene)
	cooldown_timer.start(item.cooldown)

func _get_item() -> Item:
	match input_action:
		"action_left_click":
			return Utils.game_data.main_weapon
		"action_right_click":
			return Utils.game_data.secondary_weapon
		"action_slot_1":
			return Utils.game_data.slot1
		"action_slot_2":
			return Utils.game_data.slot2
		"action_slot_3":
			return Utils.game_data.slot3
		_:
			return null
