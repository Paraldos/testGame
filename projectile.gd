extends Node2D

@export var speed := 400.0
@export var lifetime := 3.0

var direction := Vector2.RIGHT

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()

func _on_hitbox_impact() -> void:
	queue_free()
