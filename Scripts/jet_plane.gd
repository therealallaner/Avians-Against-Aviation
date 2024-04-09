extends CharacterBody2D


@onready var gameScene = get_parent().get_parent().get_parent()
@onready var waveController = get_parent().get_parent()
@onready var waitTimer = $Timer

var target:Vector2
var spawnSpeed = 400
var attackSpeed = 1800
var damage = 50

var states = {
	"Spawning": true,
	"Waiting": false,
	"Attacking": false
}

func _physics_process(delta):
	
	if states["Spawning"]:
		var newPos = (target-position).normalized()
		var distance = (target - position).length()
		if distance < 50:
			states["Spawning"] = false
			states["Waiting"] = true
			waitTimer.start()
			return
		velocity = newPos * spawnSpeed
		
	elif states["Waiting"]:
		return
		
		
	elif states["Attacking"]:
		var move = Vector2()
		move.x = -attackSpeed
		position += move * delta

	
	move_and_slide()
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	if waveController.wave not in waveController.bossWaves:
		gameScene.score += 25 * gameScene.scoreMultiplier

func _on_timer_timeout():
	states["Waiting"] = false
	states["Attacking"] = true
