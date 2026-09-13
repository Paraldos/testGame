extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sfx: SFX = %SFX

func _open():
	animation_player.play("open")
	sfx.play()

func _close():
	animation_player.play_backwards("open")
	sfx.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	_open()

func _on_area_2d_body_exited(body: Node2D) -> void:
	_close()
