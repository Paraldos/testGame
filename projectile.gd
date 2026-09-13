extends Area2D

@export var speed := 200.0
@export var lifetime := 3.0

var direction := Vector2.RIGHT

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()

func _on_body_entered(_body: Node2D) -> void:
	queue_free()
