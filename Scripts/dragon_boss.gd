extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var flameAttack = preload("res://Scenes/Bosses/flame_attack.tscn")
@onready var fireballMarker = $FireballMarker
@onready var fireBreath = $FireBreath

@onready var fireBreathSound1 = preload("res://Assets/SFX/Boss Sounds/Dragon Sounds/DragonBreath1.wav")
@onready var fireBreathSound2 = preload("res://Assets/SFX/Boss Sounds/Dragon Sounds/DragonBreath2.wav")
@onready var fireBreathSound3 = preload("res://Assets/SFX/Boss Sounds/Dragon Sounds/DragonBreath3.wav")
@onready var fireBreathSound4 = preload("res://Assets/SFX/Boss Sounds/Dragon Sounds/DragonBreath4.wav")
@onready var fireBreathSound5 = preload("res://Assets/SFX/Boss Sounds/Dragon Sounds/DragonBreath5.wav")
@onready var sounds = [fireBreathSound1,fireBreathSound2,fireBreathSound3,fireBreathSound4,fireBreathSound5]

@onready var deathSound = preload("res://Assets/SFX/Boss Sounds/Dragon Sounds/DragonDying.mp3")

var HP = 30 #30
var isHovering = false
var spawnSpeed = 100
var idleSpeed = 350
var idleTimes = 1
var attackDmg = 20
var target: Vector2
var bossReward = 150
var states = {
	"Spawning": true,
	"Attacking": false,
	"Idling": false,
	"Dying": false,
	"Dead": false
}

func _ready():
	sprite.play("flying")

func _process(delta):
	if $AudioStreamPlayer2D.volume_db <= 7:
		$AudioStreamPlayer2D.volume_db += .5
		
	if !states["Spawning"]:
		if isHovering:
			if Input.is_action_just_pressed("Jump"):
				Global.Deal_Damage(self)
				Damage_Reaction()
				
	if HP <= 0:
		if !states["Dead"]:
			for s in states:
				states[s] = false
			states["Dying"] = true
	

	if states["Dying"]:
		sprite.play("dying")
		$AudioStreamPlayer2D.stream = deathSound
		$AudioStreamPlayer2D.play()
		states["Dying"] = false
		states["Dead"] = true
			
	if states["Dead"]:
			
		if !$AudioStreamPlayer2D.is_playing():
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
			target = Vector2(position.x,randf_range(50,1000))
			idleTimes = snapped(randf_range(1,5),1)
			return
		velocity = newPos * spawnSpeed
		
	if states["Idling"]:
		var newPos = (target-position).normalized()
		var distance = (target - position).length()
		if distance < 10:
			idleTimes -= 1
			if idleTimes <= 0:
				states["Idling"] = false
				Randomize_Next_State(1)
				return
			target = Vector2(position.x,randf_range(50,1000))
#			states["Idling"] = false
#			target = Vector2(position.x,position.y)
			return
		velocity = newPos * idleSpeed
		
	if states["Attacking"]:
		
		if sprite.animation == 'breath fire':
			if !sprite.is_playing():
				states["Attacking"] = false
				sprite.play("flying")
				sprite.offset.x = 0
				idleTimes = snapped(randf_range(1,5),1)
				Randomize_Next_State(2)
			else:
				return
				
		else:
			Fireball_Attack()
		
		velocity = Vector2(0,0)
		
		
		
	if states["Dying"]:
		target = Vector2(position.x,position.y) 
		var newPos = (target - position).normalized()
		velocity = newPos * 0
		
	if states["Dead"]:
		target = Vector2(position.x,position.y) 
		var newPos = (target - position).normalized()
		velocity = newPos * 0
		
	move_and_slide()
	
	


func Randomize_Next_State(x):
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
	sprite.self_modulate = Color(1,0,.29,1)
	await(get_tree().create_timer(.25).timeout)
	sprite.self_modulate = Color(1,1,1,1)
	
func Fireball_Attack():
	sprite.play("breath fire")
	sprite.offset.x = -100
	fireBreath.stream = Global.Random_List(sounds)
	fireBreath.play()
	
func Spawn_Fireball():
	var instance = flameAttack.instantiate()
	get_parent().add_child(instance)
	instance.position = fireballMarker.global_position
	instance.fireBallDmg = attackDmg
	instance.explosionDmg = attackDmg/2


func _on_area_2d_mouse_entered():
	isHovering = true


func _on_area_2d_mouse_exited():
	isHovering = false


func _on_animated_sprite_2d_frame_changed():
	if sprite.animation == 'breath fire':
		if sprite.frame == 6:
			Spawn_Fireball()
