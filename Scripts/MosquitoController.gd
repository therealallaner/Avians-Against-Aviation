extends Node

@onready var blackMossy1 = preload("res://Scenes/Mosquitos/black_mosquito_1.tscn")
@onready var blackMossy2 = preload("res://Scenes/Mosquitos/black_mosquito_2.tscn")
@onready var blackMossy3 = preload("res://Scenes/Mosquitos/black_mosquito_3.tscn")
@onready var redMossy = preload("res://Scenes/Mosquitos/red_mosquito_1.tscn")
@onready var purpleMossy = preload("res://Scenes/Mosquitos/purple_mosquito.tscn")
@onready var purpleMossy2 = preload("res://Scenes/Mosquitos/purple_mosquito_2.tscn")
@onready var shapes = $Shapes
@onready var bossRewards = $BossRewards

@onready var blackMossies = [blackMossy1, blackMossy2]
@onready var redMossies = [redMossy]
@onready var bossRewardStep = 5

@onready var mossyColors = [
	blackMossy1, 
	blackMossy2, 
	blackMossy3, 
	redMossy,
	purpleMossy,
	purpleMossy2
	]

func _ready():
	if Global.demo:
		bossRewardStep = 2

func Spawn_Mossies():
	var shape = Global.Random_List(shapes.get_children())
	#var list = Global.Random_List(mossyColors)
	var yPos = randf_range(100,980)
	for p in shape.get_children():
		var instance = Global.Random_List(mossyColors).instantiate()
		add_child(instance)
		instance.position.x = p.position.x + 2000
		instance.position.y = p.position.y + yPos
		
		
func Spawn_Boss_Rewards_Test(x=0,nextWave=true):
	var shape = Global.Random_List(bossRewards.get_children())
	var yPos = randf_range(100,980)
	
	for p in shape.get_children():
		var instance = Global.Random_List(mossyColors).instantiate()
		add_child(instance)
		instance.position.x = p.position.x + 2000
		instance.position.y = p.position.y + yPos
		
	if x > 0:
		Spawn_Boss_Rewards((x-1),false)
		
	await(get_tree().create_timer(7).timeout)

	if nextWave:
		get_parent().Next_Wave()
		
		
func Spawn_Boss_Rewards(x,nextWave=true):
	print('boss reward step: ',bossRewardStep)
	var y = ((x-1)%bossRewardStep)+1
	var z = ceil((x-1)/bossRewardStep)+1
	print(x)
	print(y)
	print(z)
	print('')
	
	var yPos = randf_range(150,930)
	var yPosVar = Global.Random_List([30,-30])
	
	var shapeList = []
			
	for o in range(z):
		for i in range(y):
			if o <= 0:
				var shape = Global.Random_List(bossRewards.get_children())
				shapeList.append(shape)
			for p in shapeList[i].get_children():
				var instance = Global.Random_List(mossyColors).instantiate()
				add_child(instance)
				instance.position.x = p.position.x + (1920+(1080*i))
				instance.position.y = p.position.y + yPos + (yPosVar*o)
		
	var awaitTime = 5*y
	await(get_tree().create_timer(awaitTime).timeout)
	
	if nextWave:
		get_parent().Next_Wave()
