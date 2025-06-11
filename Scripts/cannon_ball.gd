extends CharacterBody2D


@export var speed : int = 500

var target : Vector2 = Vector2(384,500)


func _ready():
	print(target)

func _physics_process(delta):
	var newPos = (target-position).normalized()
	var distance = (target - position).length()
	velocity = newPos * speed
	move_and_slide()
