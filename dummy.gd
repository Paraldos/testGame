extends Node2D
@onready var hit_animation: HitAnimation = $HitAnimation

func _on_hurtbox_hit_received(hitbox: Hitbox) -> void:
	print(hitbox.dmg)
	hit_animation.play()
