extends Node2D


@onready var sprite = $AnimatedSprite2D
@onready var poisonSmoke = $PoisonSmoke
@onready var poisonTrail = $PoisonTrail
@onready var timer = $Timer

var hoverSpeed = 50
var flySpeed = 300


func _ready():
	if self.is_in_group('Poison Mossy'):
		timer.wait_time = randf()
		hoverSpeed *= Global.Random_List([-1,1])
		
	else:
		timer.wait_time = .50
		
	sprite.play("flying")
	if poisonSmoke:
		poisonSmoke.play("smoke")
		poisonTrail.play("trail")


func _process(delta):
	position.y += hoverSpeed * delta
	position.x += -flySpeed * delta


func _on_timer_timeout():
	
	if self.is_in_group('Poison Mossy'):
		timer.wait_time = randf_range(.25,.75)
	else:
		timer.wait_time = .50
		
	hoverSpeed *= -1
