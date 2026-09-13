extends Node
class_name AttackController

@export var attack: Attack

var cooldown_timer = Timer.new()

func _ready() -> void:
	add_child(cooldown_timer)
	cooldown_timer.one_shot = true

func use(pos: Vector2, direction: Vector2) -> void:
	if !cooldown_timer.is_stopped():
		return
	if attack == null:
		push_error("no attack")
		return
	cooldown_timer.start(attack.cooldown)
	attack.use(pos, direction, get_tree().current_scene)
