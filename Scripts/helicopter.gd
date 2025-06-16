extends CharacterBody2D


@onready var sprite = $AnimatedSprite2D
@onready var muzzleTimer = $MuzzleFlash/MuzzleFlashTimer
@onready var attackTimer = $MuzzleFlash/AttackingTimer
@onready var muzzleFlash = $MuzzleFlash
@onready var muzzleFlash2 = $MuzzleFlash2
@onready var muzzleFlash3 = $MuzzleFlash3
@onready var muzzleMarker = $AnimatedSprite2D/MuzzleMarker
@onready var muzzleMarker2 = $AnimatedSprite2D/MuzzleMarker2
@onready var muzzleMarker3 = $AnimatedSprite2D/MuzzleMarker3
@onready var HBMarker = $AnimatedSprite2D/HitBoxMarker

@onready var miniGunPlayer = preload("res://Scenes/Bosses/mini_gun.tscn")
var shotSound = 0

var HP = 50 #50
var maxHP: int
var isHovering = false
var spawnSpeed = 100
var attackSpeed = 50
var idleSpeed = 200
var idleTimes = 1
var target: Vector2
var defaultXPos = 1670
var bossReward = 100

var miniGunDMG = 1
var firing = false
var birdLoS = false
var phase = 1

var states = {
	"Spawning": true,
	"Attacking": false,
	"Idling": false,
	"Dying": false,
	"Dead": false
}

func _ready():
	sprite.play("flying")
	maxHP = HP
	
	
func _process(delta):
	if $AudioStreamPlayer2D.volume_db <= 7:
		$AudioStreamPlayer2D.volume_db += .5
		
		
	if !states["Spawning"]:
		if isHovering:
			if Input.is_action_just_pressed("Jump"):
				Global.Deal_Damage(self)
				Damage_Reaction()
				
				
	if HP <= (maxHP*.67):
		phase = 2
		$MuzzleArea2.show()
		
	if HP <= (maxHP*.33):
		phase = 3
		$MuzzleArea3.show()
				
	if HP <= 0:
		if !states["Dead"]:
			for s in states:
				states[s] = false
			
			states["Dying"] = true
		
	if states["Dying"]:
		sprite.play("explosion")
		attackTimer.stop()
		muzzleTimer.stop()
		states["Dying"] = false
		states["Dead"] = true
			
	if states["Dead"]:
		if !sprite.is_playing():
#		get_parent().waveController.Next_Wave()
			get_parent().waveController.mossyController.Spawn_Boss_Rewards(bossReward)
			get_parent().bossHPBar.hide()
			Global.playerStats['Bosses Defeated'] += 1
			queue_free()
	
	
func _physics_process(delta):
	if states["Spawning"]:
		var newPos = (target-position).normalized()
		var distance = (target - position).length()
		sprite.rotation_degrees = 0
		$Area2D.rotation_degrees = 0
		$Area2D.position = HBMarker.position
		if distance < 10:
			states["Spawning"] = false
			states["Idling"] = true
			target = Vector2(defaultXPos,randf_range(50,1000))
			idleTimes = snapped(randf_range(1,5),1)
			return
		velocity = newPos * spawnSpeed
		
	
	if states["Idling"]:
		muzzleFlash3.visible = false
		muzzleFlash2.visible = false
		muzzleFlash.visible = false
		
		
		var newPos = (target-position).normalized()
		var distance = (target - position).length()
		sprite.rotation_degrees = 20
		$Area2D.rotation_degrees = 20
		$Area2D.position = HBMarker.position
		if distance < 10:
			idleTimes -= 1
			if idleTimes <= 0:
				states["Idling"] = false
				states["Attacking"] = true
				target = Vector2(position.x-50,position.y)
			else:
				target = Vector2(defaultXPos,randf_range(50,1000))
			return
		velocity = newPos * idleSpeed
		
	
	if states["Attacking"]:
		var newPos = (target - position).normalized()
		var distance = (target - position).length()
		sprite.rotation_degrees = 10
		$Area2D.rotation_degrees = 10
		$Area2D.position = HBMarker.position
		if !firing:
			Fire_Minigun()
			return
		velocity = newPos * attackSpeed
		
		
	if states["Dying"]:
		target = Vector2(position.x,position.y) 
		var newPos = (target - position).normalized()
		velocity = newPos * 0
		
	if states["Dead"]:
		target = Vector2(position.x,position.y) 
		var newPos = (target - position).normalized()
		velocity = newPos * 0
		
	move_and_slide()


func Fire_Minigun():
	firing = true
	attackTimer.start()
	muzzleTimer.start()
	
	



func _on_muzzle_flash_timer_timeout():
	
		
	muzzleFlash.global_position = muzzleMarker.global_position
	muzzleFlash.visible = !muzzleFlash.visible
	print(birdLoS)
	if birdLoS:
		birdLoS.Take_Heli_Damage(miniGunDMG)
	
	if phase >= 2:
		if shotSound == 1:
			var instance = miniGunPlayer.instantiate()
			get_parent().add_child(instance)
		muzzleFlash2.global_position = muzzleMarker2.global_position
		muzzleFlash2.rotation_degrees = 10
		muzzleFlash2.visible = !muzzleFlash2.visible
	if phase == 3:
		if shotSound == 3:
			var instance = miniGunPlayer.instantiate()
			get_parent().add_child(instance)
		muzzleFlash3.global_position = muzzleMarker3.global_position
		muzzleFlash3.rotation_degrees = -10
		muzzleFlash3.visible = !muzzleFlash3.visible
		
	if firing:
		muzzleTimer.start()
		
		
	if shotSound == 5:
		var instance = miniGunPlayer.instantiate()
		get_parent().add_child(instance)
		shotSound = 0
		
	shotSound += 1
	
func _on_attacking_timer_timeout():
	firing = false
	states["Attacking"] = false
	states["Idling"] = true
	target = Vector2(defaultXPos,randf_range(50,1000))
	idleTimes = snapped(randf_range(1,5),1)



func Damage_Reaction():
	sprite.self_modulate = Color(1,0,.29,1)
	await(get_tree().create_timer(.25).timeout)
	sprite.self_modulate = Color(1,1,1,1)
	

func _on_area_2d_mouse_entered():
	isHovering = true


func _on_area_2d_mouse_exited():
	isHovering = false



func _on_muzzle_area_1_area_entered(area):
	if area.get_parent().is_in_group('Bird'):
		birdLoS = area.get_parent()


func _on_muzzle_area_1_area_exited(area):
	if area.get_parent().is_in_group('Bird'):
		birdLoS = null


func _on_muzzle_area_2_area_entered(area):
	if phase >= 2:
		if area.get_parent().is_in_group('Bird'):
			birdLoS = area.get_parent()


func _on_muzzle_area_2_area_exited(area):
	if phase >= 2:
		if area.get_parent().is_in_group('Bird'):
			birdLoS = null


func _on_muzzle_area_3_area_entered(area):
	if phase == 3:
		if area.get_parent().is_in_group('Bird'):
			birdLoS = area.get_parent()


func _on_muzzle_area_3_area_exited(area):
	if phase == 3:
		if area.get_parent().is_in_group('Bird'):
			birdLoS = null



