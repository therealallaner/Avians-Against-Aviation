extends Node2D


@onready var fireball = $Fireball
@onready var explosion = $Explosion
@onready var eShape = $Explosion/eArea/eCollision.shape
var speed = -500
var target : Vector2


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
	fireball.show()
	fireball.play("fireball")
	explosion.hide()
	
	target = Vector2(384,position.y)


func _process(delta):
	
	position.x += speed * delta
	
	Check_Target()
	
	Explosion_Size()
	
	Check_Explosion()
	
	
func Check_Target():
	print('Checkig for Target')
	if states['flying']:
		print('flying')
		if position <= target:
			print('we have reached the target!')
			speed = 0
			fireball.hide()
			explosion.show()
			explosion.play("explosion")
			states['flying'] = false
			states['exploding'] = true
		
		
func Check_Explosion():
	print('Checking for Explosion')
	if states['exploding']:
		print('It should be exploding rn.')
		if explosion.animation == 'explosion':
			if !explosion.is_playing():
				print('explosion anim should be done now')
				queue_free()
			
			
func Explosion_Size():
	eShape.set_radius(explosionAreaSize[explosion.frame])


