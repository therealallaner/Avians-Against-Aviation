extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var swarms = $Shapes.get_children()
@onready var cloud = $PoisonCloud
@onready var gameScene = get_parent().get_parent().get_parent()
@onready var poisonMossy = preload("res://Scenes/Mosquitos/poison_mosquito.tscn")

var HP = 30 #30
var isHovering = false
var spawnSpeed = 100
var idleSpeed = 350
var idleTimes = 1
var swarmSpeed = 200
var swarmTimes = 1
var target: Vector2
var bossReward = 0
var states = {
	"Spawning": true,
	"Attacking": false,
	"Swarming": false,
	"Idling": false,
	"Dying": false,
	"Dead": false
}


func _ready():
	sprite.play("flying")

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
		sprite.play("dying")
		states["Dying"] = false
		states["Dead"] = true
			
	if states["Dead"]:
		if !sprite.is_playing():
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
				swarmTimes = snapped(randf_range(1,5),1)
				Randomize_Next_State(1)
				return
			target = Vector2(position.x,randf_range(50,1000))
#			states["Idling"] = false
#			target = Vector2(position.x,position.y)
			return
		velocity = newPos * idleSpeed
		
	if states["Attacking"]:
		states["Attacking"] = false
		swarmTimes = snapped(randf_range(1,5),1)
		idleTimes = snapped(randf_range(1,5),1)
		Randomize_Next_State(2)
		
		
	if states["Swarming"]:
		var newPos = (target-position).normalized()
		var distance = (target - position).length()
		if distance < 10:
			swarmTimes -= 1
			if swarmTimes <= 0:
				states["Swarming"] = false
				idleTimes = snapped(randf_range(1,5),1)
				Randomize_Next_State(3)
				return
			Spawn_Mossies()
			target = Vector2(position.x,randf_range(50,1000))
			return
		velocity = newPos * swarmSpeed
		
		
		states["Swarming"] = false
		Randomize_Next_State(3)
		
	move_and_slide()
	
	
func Spawn_Mossies():
	cloud.play("cloud")
	var shape = $Shapes/SwarmShape1
	var xPos = position.x
	var yPos = position.y
	var x = snapped(randf_range(5,10),1)
	
	for i in range(x):
		var marker = Marker2D.new()
		shape.add_child(marker)
		marker.position.x = randf_range(-120,120)
		marker.position.y = randf_range(-120,120)
		
	for p in shape.get_children():
		var instance = poisonMossy.instantiate()
		get_parent().add_child(instance)
		instance.position.x = p.position.x + xPos
		instance.position.y = p.position.y + yPos
	
	for p in shape.get_children():
		p.queue_free()

func Randomize_Next_State(x):
	var r = randf()
	if x == 1:
		if r >= .5:
			states["Attacking"] = true
		else:
			states["Swarming"] = true
			target = position
	if x == 2:
		if r >= .5:
			states["Idling"] = true
		else:
			states["Swarming"] = true
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

func _on_area_2d_mouse_entered():
	isHovering = true


func _on_area_2d_mouse_exited():
	isHovering = false
