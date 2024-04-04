extends CharacterBody2D



var HP = 20
var isHovering = false
var speed = 100
var target: Vector2
var states = {
	"Spawning": true,
	"Attacking": false,
	"Swarming": false,
	"Idling": false,
	"Dying": false
}



func _process(delta):
	if !states["Spawning"]:
		if isHovering:
			if Input.is_action_just_pressed("Jump"):
				Global.Deal_Damage(self)
				
	if HP <= 0:
		for s in states:
			states[s] = false
		states["Dying"] = true
		
	if states["Dying"]:
		get_parent().waveController.Next_Wave()
		queue_free()

func _physics_process(delta):
	if states["Spawning"]:
		var newPos = (target-position).normalized()
		var distance = (target - position).length()
		if distance < 10:
			states["Spawning"] = false
			states["Idling"] = true
			target = Vector2(position.x,randf_range(50,1000))
			return
		velocity = newPos * speed
		
	if states["Idling"]:
		var newPos = (target-position).normalized()
		var distance = (target - position).length()
		if distance < 10:
			target = Vector2(position.x,randf_range(50,1000))
#			states["Idling"] = false
#			target = Vector2(position.x,position.y)
			return
		velocity = newPos * speed
		
	if states["Attacking"]:
		pass # Shoot gunk out at the player in a straight line from its current y coord
		# Then transition into either Idle or Swarm
	if states["Swarming"]:
		pass # Spawn x number of poison mosquitos that will swarm towards the player
		# Then transition into either Idle or Attack
		
	move_and_slide()

func _on_area_2d_mouse_entered():
	isHovering = true


func _on_area_2d_mouse_exited():
	isHovering = false
