extends CharacterBody2D


@export var blackProp: Texture
@export var pinkProp: Texture
@export var redProp: Texture
@export var yellowProp: Texture

@onready var variations = [blackProp,pinkProp,redProp,yellowProp]

var xSpeed = 300
var ySpeed = 50

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
	ySpeed = randf_range(20.0,60.0)
	ySpeed *= -1
	$wobblyTimer.wait_time = randf_range(.5,3.0)
