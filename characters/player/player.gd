extends CharacterBody2D

@onready var main_sprite: Sprite2D = %MainSprite
@onready var orientation_indicator: Node2D = %OrientationIndicator
@onready var attack_marker: Marker2D = %AttackMarker
@onready var main_sprite_animation_player: AnimationPlayer = %MainSpriteAnimationPlayer

const PROJECTILE = preload("uid://byx5cs6tgcrb6")

@export var max_speed := 60.0
@export var acceleration := 400.0

func _physics_process(delta: float) -> void:
	_orientation()
	_move(delta)
	if Input.is_action_just_pressed("ui_inventory"):
		ModalManager.open_modal(ModalManager.inventory_modal)

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
