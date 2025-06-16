extends CharacterBody2D


@onready var gameScene = get_parent().get_parent().get_parent()
@onready var waveController = get_parent().get_parent()
@onready var waitTimer = $Timer
@onready var soundTimer = $Timer2

@onready var jetSound1 = preload("res://Assets/SFX/ES_Pass By, Designed, Long & Short, Small, Fast 01 - Epidemic Sound - 0000-3448.wav")
@onready var jetSound2 = preload("res://Assets/SFX/ES_Pass By, Designed, Long & Short, Small, Fast 01 - Epidemic Sound - 4835-8028.wav")


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
			soundTimer.start()
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
	await(get_tree().create_timer(2).timeout)
	queue_free()
	if waveController.wave not in waveController.bossWaves:
		gameScene.score += 25 * UpgradeText.scoreMultiplier

func _on_timer_timeout():
	states["Waiting"] = false
	states["Attacking"] = true


func _on_timer_2_timeout():
	if !$AudioStreamPlayer2D.stream:
		$AudioStreamPlayer2D.stream = Global.Random_List([jetSound1,jetSound2])
		print($AudioStreamPlayer2D.stream)
		$AudioStreamPlayer2D.play()
