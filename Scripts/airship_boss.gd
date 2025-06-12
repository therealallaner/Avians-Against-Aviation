extends CharacterBody2D


@onready var sprite = $"Airship Anim"
@onready var deathController = $DeathAnimController
@onready var cannon = $Cannon
@onready var cannonBallMarker = $Cannon/CannonBallMarker
@onready var cannonBallTarget = $Cannon/TargetContainer.get_children()
@onready var cannonBall = preload("res://Scenes/Bosses/cannon_ball.tscn")


var gameScene : Node2D
var cannonTarget : Vector2
var HP = 40 #40
var isHovering = false
var spawnSpeed = 100
var idleSpeed = 350
var idleTimes = 1
var target: Vector2
var bossReward = 250
var states = {
	"Spawning": true,
	"Attacking": false,
	"Idling": false,
	"Dying": false,
	"ExOne": false,
	"ExTwo": false,
	"ExThree": false,
	"Final": false,
	"Dead": false,
	"Delete": false
}

func _ready():
	sprite.play("flying")
	cannon.play("idle")
	for c in deathController.get_children():
		c.hide()
	
	
	gameScene = get_tree().root.get_node("GameScene")

func _process(delta):
	
	cannonTarget = gameScene.player.position
	$Cannon.look_at(cannonTarget)
	
	if !states["Spawning"]:
		if isHovering:
			if Input.is_action_just_pressed("Jump"):
				Global.Deal_Damage(self)
				Damage_Reaction()
				
	
	if HP <= 30:
		$DeathAnimController/Flames.play("explosion")
		$DeathAnimController/Flames.show()
	if HP <= 20:
		$DeathAnimController/Flames2.play("explosion")
		$DeathAnimController/Flames2.show()
	if HP <= 10:
		$DeathAnimController/Flames3.play("explosion")
		$DeathAnimController/Flames3.show()
		
	if HP <= 0:
		if !states["Dead"]:
			for s in states:
				states[s] = false
			states["Dying"] = true
		

	if states["Dying"]:
		print("It is reaching the dying state")
		states["Dying"] = false
		states["ExOne"] = true
		states["Dead"] = true
		
	if states["ExOne"]:
		print('It should be showing the first explosion')
		$DeathAnimController/FireExplosion.play("explosion")
		$DeathAnimController/FireExplosion.show()
		get_tree().root.get_node("GameScene").camera.Boss_Shake()
		$Cannon.stop()
		states["ExOne"] = false
		states["ExTwo"] = true
	
	
	if states["ExTwo"]:
		if !$DeathAnimController/FireExplosion.is_playing():
			$DeathAnimController/FireExplosion.hide()
			$DeathAnimController/FireExplosion2.play("explosion")
			$DeathAnimController/FireExplosion2.show()
			gameScene.camera.Boss_Shake()
			states["ExTwo"] = false
			states["ExThree"] = true
	
	
	if states["ExThree"]:
		if !$DeathAnimController/FireExplosion2.is_playing():
			$DeathAnimController/FireExplosion2.hide()
			states["ExThree"] = false
			states["Final"] = true
			$DeathAnimController/FireExplosion3.play("explosion")
			$DeathAnimController/FireExplosion3.show()
			gameScene.camera.Boss_Shake()
		
		
	if states["Final"]:
		if !$DeathAnimController/FireExplosion3.is_playing():
			$DeathAnimController/FireExplosion3.hide()
			$DeathAnimController/FullExplosion.play("deathExplosion")
			$DeathAnimController/FullExplosion.show()
			$Airship.hide()
			$Cannon.hide()
			HP = 100
			$DeathAnimController/Flames.hide()
			$DeathAnimController/Flames2.hide()
			$DeathAnimController/Flames3.hide()
			gameScene.camera.Boss_Shake()
			gameScene.camera.Boss_Shake()
			states["Final"] = false
			states["Delete"] = true
	
	
	if states["Delete"]:
		if !$DeathAnimController/FullExplosion.is_playing():
			get_parent().waveController.mossyController.Spawn_Boss_Rewards(bossReward)
			get_parent().bossHPBar.hide()
			Global.playerStats['Bosses Defeated'] += 1
			queue_free()
	

func _physics_process(delta):
	if states["Spawning"]:
		var newPos = (target-position).normalized()
		var distance = (target - position).length()
		if distance < 10:
			states["Spawning"] = false
			states["Idling"] = true
			target = Vector2(position.x,randf_range(100,900))
			idleTimes = snapped(randf_range(1,5),1)
			return
		velocity = newPos * spawnSpeed
		
	elif states["Idling"]:
		var newPos = (target-position).normalized()
		var distance = (target - position).length()
		if distance < 10:
			idleTimes -= 1
			if idleTimes <= 0:
				states["Idling"] = false
				Randomize_Next_State()
				return
			target = Vector2(position.x,randf_range(100,900))
#			states["Idling"] = false
#			target = Vector2(position.x,position.y)
			return
		velocity = newPos * idleSpeed
		
	elif states["Attacking"]:
		velocity = Vector2(0,0)
		states["Attacking"] = false
		Cannon_Attack()
		await(get_tree().create_timer(.25).timeout)
		idleTimes = snapped(randf_range(1,5),1)
		Randomize_Next_State()
	
	
	else:
		velocity = Vector2(0,0) * 0
	
	move_and_slide()
	
	


func Randomize_Next_State(x=3):
	var r = randf()
	if x == 1:
		if r >= .5:
			states["Attacking"] = true
		else:
			states["Attacking"] = true
			target = position
	if x == 2:
		if r >= .5:
			states["Idling"] = true
		else:
			states["Idling"] = true
			target = position
	if x == 3:
		if r >= .5:
			states["Attacking"] = true
		else:
			states["Idling"] = true
			
			
func Damage_Reaction():
	$Airship.self_modulate = Color(1,0,.29,1)
	await(get_tree().create_timer(.25).timeout)
	$Airship.self_modulate = Color(1,1,1,1)

func Cannon_Attack():
	cannon.play("firing")
	await(get_tree().create_timer(.25).timeout)
	var instance = cannonBall.instantiate()
	get_parent().add_child(instance)
	instance.position = cannonBallMarker.global_position
	instance.target = Global.Random_List(cannonBallTarget).global_position
#	instance.target = cannonBallTarget.global_position



func _on_area_2d_mouse_entered():
	isHovering = true


func _on_area_2d_mouse_exited():
	isHovering = false


func _on_cannon_animation_finished():
	if cannon.animation == "firing":
		cannon.play("idle")
