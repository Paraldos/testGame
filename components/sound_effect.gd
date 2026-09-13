extends Resource
class_name SFX

@export var sound := AudioManager.Sound.HURT
@export var pitch_variation := 0.0

func play():
	AudioManager.play_sfx(sound, pitch_variation)

func play_at_pos(pos: Vector2):
	AudioManager.play_sfx_2d(sound, pos, pitch_variation)
