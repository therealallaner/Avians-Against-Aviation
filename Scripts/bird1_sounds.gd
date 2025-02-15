extends Node


@export var sound1: AudioStream
@export var sound2: AudioStream
@export var sound3: AudioStream
@export var sound4: AudioStream
@export var sound5: AudioStream

@onready var sounds = [sound1,sound2,sound3,sound4,sound5]
@onready var tweets = $AudioStreamPlayer2D
@onready var timer = $Timer

var timerRange = [5, 15]


func _on_timer_timeout():
	var sound = Global.Random_List(sounds)
	var range = randf_range(10,30)
	tweets.stream = sound
	tweets.play()
	timer.wait_time = range
	timer.start()
