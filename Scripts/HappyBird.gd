extends Happy_Birds

@onready var animPlayer = $AnimationPlayer
@onready var visibility = $VisibleOnScreenNotifier2D
@onready var player = get_parent()


var offScreen = false
var offScreenDamage = .5




func _ready():
	Anim_Controller(animPlayer)
	visibility.hide()
	

func _process(delta):
	if get_parent().is_class("CharacterBody2D"):
		if player.HP <= 0:
			if Engine.time_scale == 1:
				Global.Game_Over()
			
			
func _on_visible_on_screen_notifier_2d_screen_exited():
	if Engine.time_scale == 1:
		if get_parent().is_class("CharacterBody2D"):
			offScreen = true
			var damageX: float = 1.0
			while offScreen:
				player.HP -= offScreenDamage*damageX
				First_Time_Damage()
				damageX += .5
				await(get_tree().create_timer(.05).timeout)
		
	
func _on_visible_on_screen_notifier_2d_screen_entered():
	offScreen = false

func Damage_Reaction():
	self.self_modulate = Color(1,0,.29,1)
	await(get_tree().create_timer(.5).timeout)
	self.self_modulate = Color(1,1,1,1)
	

func _on_area_2d_body_entered(body):
	if body.is_in_group("Plane"):
		if Engine.time_scale == 1:
			player.HP -= body.damage
			Damage_Reaction()
			First_Time_Damage()


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("Mossy"):
		if self.position.x >= 1920:
			print("Bird Card did not eat Mossies")
			return
		get_parent().get_parent().mossies += 1
		area.get_parent().queue_free()
		player.HP += 1
		if player.HP > 100:
			player.HP = 100
		get_parent().Mossy_Bite()
			
			
	if area.get_parent().is_in_group("Poison Mossy"):
		Damage_Over_Time()
		area.get_parent().queue_free()
		get_parent().Mossy_Bite()

	if area.get_parent().is_in_group("Torpedo"):
		player.HP -= area.get_parent().damage 
		First_Time_Damage()
		
		

func Damage_Over_Time():
	for x in range(snapped(randf_range(5,10),1)):
		if player.get_class() != "Container":
			self.self_modulate = Color(.11,1,.15,1)
			player.HP -= 2
			First_Time_Damage()
			await(get_tree().create_timer(.75).timeout)
			self.self_modulate = Color(1,1,1,1)
			await(get_tree().create_timer(.25).timeout)
			
func First_Time_Damage():
	if !Global.tipTriggers['hasTakenDamage']:
		player.get_parent().tipController.Damage_Taken_Tip()
