extends Happy_Birds

@onready var animPlayer = $AnimationPlayer


func _ready():
	Anim_Controller(animPlayer)


func _on_visible_on_screen_notifier_2d_screen_exited():
	Global.Game_Over()



func _on_area_2d_body_entered(body):
	if body.is_in_group("Plane"):
		Global.Game_Over()


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("Mossy"):
		get_parent().get_parent().mossiesEaten += 1
		print(get_parent().get_parent().mossiesEaten)
		area.get_parent().queue_free()
