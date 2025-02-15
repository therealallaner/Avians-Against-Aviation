extends Node


@export var sound1: AudioStream
@export var sound2: AudioStream
@export var sound3: AudioStream
@export var sound4: AudioStream
@export var sound5: AudioStream
@export var sound6: AudioStream
@export var sound7: AudioStream
@export var sound8: AudioStream
@export var sound9: AudioStream
@export var sound10: AudioStream
@export var sound11: AudioStream
@export var sound12: AudioStream
@export var sound13: AudioStream

@onready var sounds = [
sound1,
sound2,
sound3,
sound4,
sound5,
sound6,
sound7,
sound8,
sound9,
sound10,
sound11,
sound12,
sound13
]


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
