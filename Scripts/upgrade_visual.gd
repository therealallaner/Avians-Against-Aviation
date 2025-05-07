extends TextureProgressBar



@onready var timer = $Timer

	
func _process(delta):
	value = timer.time_left * 100

func _on_timer_timeout():
	queue_free()
