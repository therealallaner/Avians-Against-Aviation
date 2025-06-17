extends Node2D


@onready var fireball = $Fireball
@onready var explosion = $Explosion
@onready var eShape = $Explosion/eArea/eCollision.shape
@onready var fireCracklePlayer = $Fireball/AudioStreamPlayer2D
@onready var ignitionPlayer = $Explosion/AudioStreamPlayer2D

@onready var fireCrackle1 = preload("res://Assets/SFX/Boss Sounds/Dragon Sounds/Fire/FireCrackle1.mp3")
@onready var fireCrackle2 = preload("res://Assets/SFX/Boss Sounds/Dragon Sounds/Fire/FireCrackle2.mp3")
@onready var fireIgnition = preload("res://Assets/SFX/Boss Sounds/Dragon Sounds/Fire/FireIgnition.mp3")

@export var speed = -1000

var target : float = 0.0
var fireBallDmg : int
var explosionDmg : int

var states = {
	'flying': true,
	'exploding': false
}

var explosionAreaSize = {
	0:0.0,
	1:45.0,
	2:110.0,
	3:145.0,
	4:155.0,
	5:180.0,
	6:0.0,
	7:0.0
}


func _ready():
	Ready_Up()


func _process(delta):
	position.x += speed * delta
	
	Check_Target()
	Check_Anim()
	Explosion_Size()

func Ready_Up():
	target = 384.0
	fireball.show()
	fireball.play("fireball")
	explosion.hide()
	fireCracklePlayer.stream = Global.Random_List([fireCrackle1,fireCrackle2])
	fireCracklePlayer.play()

func Check_Target():
	if states['flying']:
		if position.x <= target:
			
			fireball.hide()
			speed = 0
			explosion.show()
			explosion.play("explosion")
			fireCracklePlayer.stop()
			ignitionPlayer.play()
			
			states['flying'] = false
			states['exploding'] = true

func Check_Anim():
	if !states['exploding']:
		return
	else:
		if !explosion.is_playing():
			queue_free()

func Explosion_Size():
	eShape.set_radius(explosionAreaSize[explosion.frame])


