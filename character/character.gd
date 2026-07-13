class_name Character
extends CharacterBody2D

@onready var path_line: Line2D = %PathLine

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	path_line.global_position = Vector2.ZERO
