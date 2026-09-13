extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var sfx: SoundEffect

func _open():
	animation_player.play("open")

func _close():
	animation_player.play_backwards("open")

func _on_area_2d_body_entered(_body: Node2D) -> void:
	_open()
	sfx.play_at_pos(global_position)

func _on_area_2d_body_exited(_body: Node2D) -> void:
	_close()
	sfx.play_at_pos(global_position)
