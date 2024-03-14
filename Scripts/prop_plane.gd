extends CharacterBody2D


@export var blackProp: Texture
@export var pinkProp: Texture
@export var redProp: Texture
@export var yellowProp: Texture

@onready var variations = [blackProp,pinkProp,redProp,yellowProp]

var xSpeed = 300
var ySpeed = randf_range(-60.0,60.0)

func _ready():
	var planeSkin = Global.Random_List(variations)
	$Sprite2D.texture = planeSkin


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
	queue_free()
