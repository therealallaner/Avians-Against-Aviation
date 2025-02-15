extends Node


@export var sound1: AudioStream
@export var sound2: AudioStream

@onready var sounds = [sound1,sound2]
@onready var tweets = $AudioStreamPlayer2D
@onready var timer = $Timer

var timerRange = [5, 15]


func _on_timer_timeout():
	var sound = Global.Random_List(sounds)
	var range = randf_range(10,30)
	var pitch = randf_range(-1,1)
	tweets.stream = sound
	tweets.pitch_scale += pitch
	tweets.play()
	timer.wait_time = range
	timer.start()
