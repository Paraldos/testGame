extends Node
class_name Attack

@export var projectile: ProjectileDefinition
@export var sfx: SoundEffect

var cooldown_timer = Timer.new()

func _ready() -> void:
	add_child(cooldown_timer)
	cooldown_timer.one_shot = true

func use(pos: Vector2, direction: Vector2) -> void:
	if !cooldown_timer.is_stopped():
		return
	if projectile == null:
		push_error("Attack has no projectile.")
		return
	cooldown_timer.start(projectile.cooldown)
	sfx.play()
	var p := projectile.spawn_projectile(pos, direction)
	get_tree().current_scene.add_child(p)
