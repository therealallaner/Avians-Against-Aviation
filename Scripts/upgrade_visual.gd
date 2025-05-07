extends TextureProgressBar

@export var upgradeImage : Texture2D


@onready var timer = $Timer

func _ready():
	texture_over = upgradeImage
	
func _process(delta):
	value = timer.time_left * 100

func _on_timer_timeout():
	queue_free()
