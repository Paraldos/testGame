extends Node2D
class_name SFX

@export var sfx = AudioManager.Sound.HURT
@export var pitch_variation = 0.0
@export var local = false

func play():
	if local:
		AudioManager.play_sfx_2d(sfx, global_position, pitch_variation)
	else:
		AudioManager.play_sfx(sfx, pitch_variation)
