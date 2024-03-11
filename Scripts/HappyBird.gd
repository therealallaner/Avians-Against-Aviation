extends Happy_Birds

@onready var animPlayer = $AnimationPlayer


func _ready():
	Anim_Controller(animPlayer)


func _on_visible_on_screen_notifier_2d_screen_exited():
	Global.Game_Over()
