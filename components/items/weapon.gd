extends Item
class_name Weapon

@export_category("Projectile")
@export var projectile : PackedScene
@export var sound_effect: SoundEffect

@export_category("Properties")
@export var speed := 400.0
@export var dmg := 10
@export_range(0.0, 180.0, 0.1, "suffix:°")
var spread := 0.0
@export var amount := 1
@export var lifetime := 3.0
@export var cooldown := 0.5

@export_category("Collision")
@export var hits_walls := true
@export var hits_player := false
@export var hits_enemy := true

func use(pos: Vector2, direction: Vector2, container : Node) -> void:
	if projectile == null:
		push_error("ProjectileValues has no PackedScene.")
		return
	sound_effect.play_at_pos(pos)
	for i in amount:
		var p := projectile.instantiate() as Projectile
		var spread_angle := deg_to_rad(randf_range(-spread, spread))
		var final_direction := direction.normalized().rotated(spread_angle)
		p.set(&"values", self)
		p.direction = final_direction
		p.global_position = pos
		p.rotation = final_direction.angle()
		container.add_child(p)
