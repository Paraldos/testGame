extends Node2D

@onready var paths: Node2D = %Paths

func _ready() -> void:
	Utils.paths = paths
