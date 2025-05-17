extends Happy_Birds

@onready var animPlayer = $AnimationPlayer
@onready var visibility = $VisibleOnScreenNotifier2D
@onready var player = get_parent()
@onready var damageNumberText = preload("res://Scenes/Main/damage_numbers.tscn")


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
	var dmg = 0
	if body.is_in_group("Plane"):
		if Engine.time_scale == 1:
			dmg = body.damage
			if dmg <= player.ES:
				player.ES -= dmg
				Damage_Numbers(dmg,3)
			elif dmg > player.ES:
				dmg -= player.ES
				if player.ES > 0:
					Damage_Numbers(player.ES,3,Vector2(0,-50))
				player.ES = 0
				player.HP -= dmg
				Damage_Numbers(dmg)
			Global.playerStats['Planes Hit'] += 1
			body.queue_free()
			
			Damage_Reaction()
			First_Time_Damage()


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("Mossy"):
		if self.position.x >= 1920:
			print("Bird Card did not eat Mossies")
			return
		if Engine.time_scale == 1:
			get_parent().get_parent().mossies += 1
		area.get_parent().queue_free()
		Heals_Over_Time()
		get_parent().Mossy_Bite()
			
			
	if area.get_parent().is_in_group("Poison Mossy"):
		Damage_Over_Time()
		area.get_parent().queue_free()
		get_parent().Mossy_Bite()

	if area.get_parent().is_in_group("Torpedo"):
		var dmg = 0
		dmg = area.get_parent().damage 
		if dmg <= player.ES:
			player.ES -= dmg
			Damage_Numbers(dmg,3)
		elif dmg > player.ES:
			dmg -= player.ES
			if player.ES > 0:
				Damage_Numbers(player.ES,3,Vector2(0,-50))
			player.ES = 0
			player.HP -= dmg
			Damage_Numbers(dmg)
				
		Damage_Reaction()
		First_Time_Damage()
		
		
	if area.get_parent().is_in_group('Upgrades'):
		var parent = area.get_parent()
		UpgradeText.Upgrade_Activator(parent)
		Global.playerStats['Power-Ups Collected'] += 1
		if parent.upgradeNumber == 2:
			Damage_Numbers(UpgradeText.energyShieldLevels[Global.upgrades['Energy Shield']],3)
		
		
func Heals_Over_Time():
	var betterHealsTime = UpgradeText.betterHealsLevelsTime[int(Global.upgrades['Better Heals'])]
	var betterHealsHP = UpgradeText.betterHealsLevels[int(Global.upgrades['Better Heals'])]
	if UpgradeText.healsOverTime:
		for x in range(betterHealsTime):
			player.HP += betterHealsHP
			Damage_Numbers(betterHealsHP,2)
			if player.HP > 100:
				player.HP = 100
			await(get_tree().create_timer(1).timeout)
			
	else:
		player.HP += 1
		Damage_Numbers(1,2)
		if player.HP > 100:
			player.HP = 100




func Damage_Over_Time():
	for x in range(snapped(randf_range(5,10),1)):
		if player.get_class() != "Container":
			self.self_modulate = Color(.11,1,.15,1)
			player.HP -= 2
			Damage_Numbers(2)
			First_Time_Damage()
			await(get_tree().create_timer(.75).timeout)
			self.self_modulate = Color(1,1,1,1)
			await(get_tree().create_timer(.25).timeout)
			

func Damage_Numbers(x,dmg=1,offset=Vector2(0,0)):
	var instance = damageNumberText.instantiate()
	add_child(instance)
	instance.label.position = self.global_position + offset
	instance.Damage_Text(x,dmg)

func First_Time_Damage():
	if !Global.tipTriggers['hasTakenDamage']:
		player.get_parent().tipController.Damage_Taken_Tip()

func Take_Heli_Damage(dmg):
	player.HP -= dmg
	Damage_Numbers(dmg)
	Damage_Reaction()
	First_Time_Damage()
