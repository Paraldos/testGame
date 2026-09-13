extends Resource
class_name ProjectileDefinition

@export var node : PackedScene

@export_category("Properties")
@export var speed := 400.0
@export var dmg := 10
@export var lifetime := 3.0
@export var cooldown := 0.5

@export_category("Collision")
@export var hits_walls := true
@export var hits_player := false
@export var hits_enemy := true

func spawn_projectile(pos: Vector2, direction: Vector2) -> Node2D:
	if node == null:
		push_error("ProjectileValues has no PackedScene.")
		return null
	var p := node.instantiate() as Projectile
	p.set(&"values", self)
	p.direction = direction.normalized()
	p.global_position = pos
	p.rotation = direction.angle()
	return p