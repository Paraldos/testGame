extends Node

const SFX_BUS := &"SFX"

enum Sound {
	HURT,
	DOOR,
}

const SOUNDS := { Sound.HURT: preload("uid://bmnb55wjwil1q"), Sound.DOOR: preload("uid://qmc0prm7jgog") }

func play_sfx(sound: Sound, pitch_variation := 0.0) -> void:
	var stream: AudioStream = SOUNDS.get(sound)
	if stream == null:
		return
	var player := AudioStreamPlayer.new()
	player.stream = stream
	player.bus = SFX_BUS
	player.pitch_scale = randf_range(1.0 - pitch_variation, 1.0 + pitch_variation)
	add_child(player)
	player.finished.connect(player.queue_free)
	player.play()

func play_sfx_2d(sound: Sound, global_position: Vector2, pitch_variation := 0.0) -> void:
	var stream: AudioStream = SOUNDS.get(sound)
	if stream == null:
		return
	var player := AudioStreamPlayer2D.new()
	player.stream = stream
	player.bus = SFX_BUS
	player.pitch_scale = randf_range(1.0 - pitch_variation, 1.0 + pitch_variation)
	add_child(player)
	player.global_position = global_position
	player.finished.connect(player.queue_free)
	player.play()
