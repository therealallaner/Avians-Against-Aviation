extends CharacterBody2D


@onready var waveController = get_parent().get_parent()
@onready var sprite = $Sprite2D
@onready var torpedo = preload("res://Scenes/Planes/torpedo.tscn")
@onready var torpedoSpawn = $Marker2D
@onready var deathSprite = $DeathAnim

var HP = 10 #10
var isHovering = false
var spawnSpeed = 100
var attackSpeed = 600
var idleSpeed = 450
var idleTimes = 1
var torpedoTimes = 5
var tTimes = 0
var recruitSpeed = 500
var target: Vector2
var bossReward = 0
var states = {
	"Spawning": true,
	"Attacking": false,
	"Recruiting": false,
	"Idling": false,
	"Retreating": false,
	"Dying": false,
	"Dead": false
}


func _ready():
	pass
	

func _process(delta):
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
		sprite.hide()
		deathSprite.show()
		deathSprite.play("explosion")
		states["Dying"] = false
		states["Dead"] = true


	if states["Dead"]:
		if !deathSprite.is_playing():
#		get_parent().waveController.Next_Wave()
			get_parent().waveController.mossyController.Spawn_Boss_Rewards(bossReward)
			get_parent().bossHPBar.hide()
			Global.playerStats['Bosses Defeated'] += 1
			queue_free()
	
func _physics_process(delta):
	if states["Spawning"]:
		sprite.flip_h = true
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
				Randomize_Next_State()
			target = Vector2(position.x,randf_range(50,1000))
			return
		velocity = newPos * idleSpeed
		
	if states["Attacking"]:
		var newPos = (target-position).normalized()
		var distance = (target - position).length()
		if distance < 10:
			tTimes -= 1
			Launch_Torpedo()
			if tTimes <= 0:
				states["Attacking"] = false
				states["Retreating"] = true
				Retreating_Target()
			else:
				target = Vector2(position.x,randf_range(50,1000))
			return
		velocity = newPos * attackSpeed
			
		
		
	if states["Recruiting"]:
		var newPos = (target-position).normalized()
		var distance = (target - position).length()
		if distance < 10:
			Spawn_Jets()
			states["Recruiting"] = false
			states["Retreating"] = true
			Retreating_Target()
			return
		velocity = newPos * attackSpeed
		
	if states["Retreating"]:
			
		var newPos = (target-position).normalized()
		var distance = (target - position).length()
		if distance < 10:
			global_position = Vector2(2120,540)
			target.x = position.x - 450
			target.y = position.y
			states["Retreating"] = false
			states["Spawning"] = true
			return
		velocity = newPos * idleSpeed
		
		
	if states["Dying"]:
		target = Vector2(position.x,position.y) 
		var newPos = (target - position).normalized()
		velocity = newPos * 0
		
	if states["Dead"]:
		target = Vector2(position.x,position.y) 
		var newPos = (target - position).normalized()
		velocity = newPos * 0
		
	move_and_slide()
	
	
func Randomize_Next_State():
	target = Vector2(position.x,randf_range(50,1000))
	var r = randf()
	if r >= .45:
		states["Attacking"] = true
		tTimes = randi_range(2,8)
	else:
		states["Recruiting"] = true
		target = position

func Launch_Torpedo():
	var instance = torpedo.instantiate()
	get_parent().add_child(instance)
	instance.position = torpedoSpawn.global_position

func Spawn_Jets():
	waveController.Jet_Spawn()
	
func Retreating_Target():
	var r = randf()
	if r <=.33:
		target.y += 1200
		target.x = position.x
	if r >= .67:
		target.y -= 1200
		target.x = position.x
	else:
		target.x = position.x + 500
		target.y = position.y
		sprite.flip_h = false
	
func Damage_Reaction():
	sprite.self_modulate = Color(1,0,.29,1)
	await(get_tree().create_timer(.25).timeout)
	sprite.self_modulate = Color(1,1,1,1)


func _on_area_2d_mouse_entered():
	isHovering = true


func _on_area_2d_mouse_exited():
	isHovering = false

