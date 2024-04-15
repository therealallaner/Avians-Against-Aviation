extends Node2D


@onready var sprite = $AnimatedSprite2D
@onready var poisonSmoke = $PoisonSmoke
@onready var poisonTrail = $PoisonTrail
@onready var timer = $Timer

var hoverSpeed = 50
var flySpeed = 300


func _ready():
	sprite.play("flying")
	poisonSmoke.play("smoke")
	poisonTrail.play("trail")


func _process(delta):
	position.y += hoverSpeed * delta
	position.x += -flySpeed * delta


func _on_timer_timeout():
	hoverSpeed *= -1
