extends Node2D

@onready var hit_fx: HitFX = %HitFX

func _on_hurtbox_hit_received(hitbox: Hitbox) -> void:
	print(hitbox.dmg)
	hit_fx.play()
