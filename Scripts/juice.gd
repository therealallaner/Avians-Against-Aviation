extends Sprite2D


@onready var animPlayer = $AnimationPlayer

func _ready():
	animPlayer.play('sparkle')
	await(get_tree().create_timer(1).timeout)
	queue_free()
