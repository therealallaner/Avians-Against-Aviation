extends Player


const JUMP_VELOCITY = -500.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	velocity.y += gravity * delta

	if Input.is_action_just_pressed("Jump"):
		velocity.y = JUMP_VELOCITY
		
		
	if velocity.y > 0:
		set_rotation(deg_to_rad(velocity.y * .05))
	else:
		set_rotation(deg_to_rad(velocity.y * .05))

	move_and_slide()


