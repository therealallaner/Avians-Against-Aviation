extends CharacterBody2D


@export var blackProp: Texture
@export var pinkProp: Texture
@export var redProp: Texture
@export var yellowProp: Texture

@onready var gameScene = get_parent().get_parent().get_parent()
@onready var variations = [blackProp,pinkProp,redProp,yellowProp]

var xSpeed = 350
var ySpeed = randf_range(-60.0,60.0)
var damage = 33

func _ready():
	var planeSkin = Global.Random_List(variations)
	$Sprite2D.texture = planeSkin
	$AudioStreamPlayer2D.play()


func _physics_process(delta):
	
	var move = Vector2()
	move.x = -xSpeed
	move.y = ySpeed
	position += move * delta
	
	move_and_slide()
	


func _on_wobbly_timer_timeout():
	ySpeed = randf_range(-60.0,60.0)
	$wobblyTimer.wait_time = randf_range(.25,2.0)


func _on_visible_on_screen_notifier_2d_screen_exited():
	if Engine.time_scale == 1:
		gameScene.score += 10 * UpgradeText.scoreMultiplier
	queue_free()
