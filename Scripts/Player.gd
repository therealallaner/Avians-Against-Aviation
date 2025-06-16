extends Player

@onready var sparkle = $Sparkle
@onready var sparkleAnim = $Sparkle/AnimationPlayer
@onready var magnet = $Magnet
@onready var magnetShape = $Magnet/CollisionShape2D
@onready var magnetAnim = $MagnetEffect

const jumpVelocity = -500.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var HP : float = 100.0
var ES = 0
var vultureActive : bool = false



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


	

func _on_magnet_area_entered(area):
	if UpgradeText.magnetActive:
		if area.get_parent().is_in_group("Mossy"):
			var mossy = area.get_parent()
			mossy.target = self
			mossy.states['flying'] = false
			mossy.states['magnetized'] = true
#			var tween = create_tween()
#			tween.parallel().tween_property(x, "position", Vector2(0,-1080), menuTransitionTime)
#			tween.set_ease(Tween.EASE_IN_OUT)
#			tween.play()


func _on_magnet_area_exited(area):
	if UpgradeText.magnetActive:
		if area.get_parent().is_in_group("Mossy"):
			var mossy = area.get_parent()
			mossy.target = null
			mossy.states['flying'] = true
			mossy.states['magnetized'] = false
