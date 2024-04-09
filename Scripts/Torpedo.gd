extends Sprite2D

var flySpeed = 1
var damage = 20


func _ready():
	$AnimatedSprite2D.play("flame")


func _process(delta):
	position.x -= flySpeed
	position.y = position.y

func _on_timer_timeout():
	if flySpeed < 600:
		flySpeed *= 2.5
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
