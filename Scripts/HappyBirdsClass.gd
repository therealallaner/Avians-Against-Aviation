extends Sprite2D
class_name Happy_Birds


var animController = false


func _process(delta):
	if animController:
		pass

func Anim_Controller(animPlayer):
	animPlayer.play("Fly")
