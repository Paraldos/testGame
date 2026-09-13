extends Node2D
class_name Projectile

@onready var hitbox: Hitbox = $Hitbox
@export var values := ProjectileDefinition.new()

var direction := Vector2.RIGHT
var remaining_lifetime := 0.0

func _ready() -> void:
	if values == null:
		push_error("Projectile has no ProjectileValues.")
		queue_free()
		return
	remaining_lifetime = values.lifetime
	hitbox.dmg = values.dmg
	hitbox.collision_mask = 0
	hitbox.set_collision_mask_value(1, values.hits_walls)
	hitbox.set_collision_mask_value(2, values.hits_player)
	hitbox.set_collision_mask_value(3, values.hits_enemy)

func _physics_process(delta: float) -> void:
	global_position += direction * values.speed * delta
	remaining_lifetime -= delta
	if remaining_lifetime <= 0.0:
		queue_free()

func _on_hitbox_impact() -> void:
	queue_free()
