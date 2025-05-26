extends Player

@onready var sparkle = $Sparkle
@onready var sparkleAnim = $Sparkle/AnimationPlayer

const jumpVelocity = -500.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var HP : float = 100.0
var ES = 0
var damage = 1


func _process(delta):
	if !sparkleAnim.is_playing():
		sparkle.hide()

func _physics_process(delta):
	if Global.gameMenu:
		if !Global.mouseHovering:
			if Input.is_action_just_pressed("Jump"):
				Global.Start_Game()
	
	else:
		velocity.y += gravity * delta

	if !Global.mouseHovering:
		if Input.is_action_just_pressed("Jump"):
			velocity.y = jumpVelocity
			Flap_Sound()
			
		
		
	if velocity.y > 0:
		set_rotation(deg_to_rad(velocity.y * .05))
	else:
		set_rotation(deg_to_rad(velocity.y * .05))

	move_and_slide()


