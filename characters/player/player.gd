extends CharacterBody2D

@onready var main_sprite: Sprite2D = %MainSprite
@onready var orientation_indicator: Node2D = %OrientationIndicator
@onready var attack_marker: Marker2D = %AttackMarker
@onready var attack_timer: Timer = %AttackTimer
@onready var main_sprite_animation_player: AnimationPlayer = %MainSpriteAnimationPlayer

const PROJECTILE = preload("uid://byx5cs6tgcrb6")

@export var max_speed := 60.0
@export var acceleration := 400.0

func _physics_process(delta: float) -> void:
	_orientation()
	_move(delta)
	if Input.is_action_pressed("attack") && attack_timer.is_stopped():
		shoot()
		attack_timer.start(0.5)

func _orientation() -> void:
	orientation_indicator.look_at(get_global_mouse_position())
	if get_local_mouse_position().x > 0:
		main_sprite.flip_h = false
	else:
		main_sprite.flip_h = true

func _move(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var target_velocity := direction * max_speed
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
		main_sprite_animation_player.play("run")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
		main_sprite_animation_player.play("idle")
	move_and_slide()

func shoot() -> void:
	var projectile := PROJECTILE.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = attack_marker.global_position
	projectile.direction = attack_marker.global_position.direction_to(get_global_mouse_position())
	projectile.rotation = projectile.direction.angle()
