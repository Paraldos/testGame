extends CharacterBody2D

@onready var main_sprite: Sprite2D = %MainSprite
@onready var orientation_indicator: Node2D = %OrientationIndicator
@onready var camera: Camera2D = %Camera

@export var max_speed := 100.0
@export var acceleration := 500.0
@export var deceleration := 400.0

func _physics_process(delta: float) -> void:
	orientation_indicator.look_at(get_global_mouse_position())
	var direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
	var target_velocity := direction * max_speed
	if direction:
		velocity = velocity.move_toward(
			target_velocity,
			acceleration * delta
		)
	else:
		velocity = velocity.move_toward(
			Vector2.ZERO,
			deceleration * delta
		)
	move_and_slide()
