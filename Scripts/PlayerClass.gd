extends CharacterBody2D
class_name Player


@onready var blackBird1 = preload("res://Scenes/Players/Sprites/black_bird_1.tscn")
@onready var greenBird1 = preload("res://Scenes/Players/Sprites/green_bird_1.tscn")
@onready var yellowBird1 = preload("res://Scenes/Players/Sprites/yellow_bird_1.tscn")
@onready var pinkBird1 = preload("res://Scenes/Players/Sprites/pink_bird_1.tscn")
@onready var redBird1 = preload("res://Scenes/Players/Sprites/red_bird_1.tscn")

@onready var blackBird2 = preload("res://Scenes/Players/Sprites/black_bird_2.tscn")
@onready var greenBird2 = preload("res://Scenes/Players/Sprites/green_bird_2.tscn")
@onready var yellowBird2 = preload("res://Scenes/Players/Sprites/yellow_bird_2.tscn")
@onready var pinkBird2 = preload("res://Scenes/Players/Sprites/pink_bird_2.tscn")
@onready var redBird2 = preload("res://Scenes/Players/Sprites/red_bird_2.tscn")
@onready var blueBird2 = preload("res://Scenes/Players/Sprites/blue_bird_2.tscn")
@onready var purpleBird2 = preload("res://Scenes/Players/Sprites/purple_bird_2.tscn")

@onready var blackBird3 = preload("res://Scenes/Players/Sprites/black_bird_3.tscn")
@onready var greenBird3 = preload("res://Scenes/Players/Sprites/green_bird_3.tscn")
@onready var yellowBird3 = preload("res://Scenes/Players/Sprites/yellow_bird_3.tscn")
@onready var pinkBird3 = preload("res://Scenes/Players/Sprites/pink_bird_3.tscn")
@onready var redBird3 = preload("res://Scenes/Players/Sprites/red_bird_3.tscn")
@onready var blueBird3 = preload("res://Scenes/Players/Sprites/blue_bird_3.tscn")
@onready var purpleBird3 = preload("res://Scenes/Players/Sprites/purple_bird_3.tscn")

@onready var currentBird = redBird1

@onready var bird1 = [blackBird1,greenBird1,yellowBird1,pinkBird1,redBird1]
@onready var bird2 = [blackBird2,greenBird2,yellowBird2,pinkBird2,redBird2,blueBird2,purpleBird2]
@onready var bird3 = [blackBird3,greenBird3,yellowBird3,pinkBird3,redBird3,blueBird3,purpleBird3]

@onready var vulture = preload("res://Scenes/Players/Sprites/vulture.tscn")

@onready var tweet1 = preload("res://Assets/SFX/Bird Tweets/Tweet 1.wav")
@onready var tweet2 = preload("res://Assets/SFX/Bird Tweets/Tweet 2.wav")
@onready var tweet3 = preload("res://Assets/SFX/Bird Tweets/Tweet 3.wav")
@onready var tweet4 = preload("res://Assets/SFX/Bird Tweets/Tweet 4.wav")

@onready var mossySound1 = preload("res://Assets/SFX/Eating Mossies/Mossy Munch 1.wav")
@onready var mossySound2 = preload("res://Assets/SFX/Eating Mossies/Mossy Munch 2.wav")
@onready var mossySound3 = preload("res://Assets/SFX/Eating Mossies/Mossy Munch 3.wav")

@onready var chimeSound1 = preload("res://Assets/SFX/Upgrades/ES_Chime, Crystal, Glint, Twinkle, Fantasy 01 - Epidemic Sound - 0000-0716.wav")
@onready var chimeSound2 = preload("res://Assets/SFX/Upgrades/ES_Chime, Crystal, Glint, Twinkle, Fantasy 01 - Epidemic Sound - 3336-4323.wav")
@onready var chimeSound3 = preload("res://Assets/SFX/Upgrades/ES_Chime, Crystal, Glint, Twinkle, Fantasy 01 - Epidemic Sound - 6665-7404.wav")

@onready var flap1 = preload("res://Assets/SFX/Bird Flap/Bird Flap 1.wav")
@onready var flap2 = preload("res://Assets/SFX/Bird Flap/Bird Flap 2.wav")


@onready var tweets = [
	tweet1,
	tweet2,
	tweet3,
	tweet4
]

@onready var mossyBites = [
	mossySound1,
	mossySound2,
	mossySound3
]

@onready var chimes = [
	chimeSound1,
	chimeSound2,
	chimeSound3
]

@onready var flaps = [
	flap1,
	flap2
]

@onready var birddict = {
	"blackBird1": blackBird1,
	"greenBird1": greenBird1,
	"yellowBird1": yellowBird1,
	"pinkBird1": pinkBird1,
	"redBird1": redBird1,
	
	"blackBird2": blackBird2,
	"greenBird2": greenBird2,
	"yellowBird2": yellowBird2,
	"pinkBird2": pinkBird2,
	"redBird2": redBird2,
	"blueBird2": blueBird2,
	"purpleBird2": purpleBird2,
	
	"blackBird3": blackBird3,
	"greenBird3": greenBird3,
	"yellowBird3": yellowBird3,
	"pinkBird3": pinkBird3,
	"redBird3": redBird3,
	"blueBird3": blueBird3,
	"purpleBird3": purpleBird3,
}

@onready var visibility: VisibleOnScreenNotifier2D

var defaultPos = Vector2(384,540)



func _ready():
	Check_Global()
		
	Change_Bird(currentBird)
	
	for c in get_children():
		if c.is_in_group("Bird"):
			visibility = c.visibility
	
	
func Check_Global():
	if Global.currentBird:
		currentBird = birddict[Global.currentBird]
	else:
		currentBird = birddict["blackBird1"]
	
func Change_Bird(bird,vulture=false):
	for c in get_children():
		if c.is_in_group("Bird"):
			c.queue_free()
	var instance = bird.instantiate()
	add_child(instance)
	instance.Anim_Controller(instance.animPlayer)
	visibility = instance.visibility
	visibility.show()
	if !vulture:
		Check_Global()
		self.global_position = defaultPos
		visibility.hide()
	
	

func Bird_Sounds():
	var sound = Global.Random_List(tweets)
	$TweetPlayer.stream = sound
	$TweetPlayer.play()

func Mossy_Bite():
	var sound = Global.Random_List(mossyBites)
	$MossyBite.stream = sound
	$MossyBite.play()


func Upgrade_Chime():
	var sound = Global.Random_List(chimes)
	$UpgradeChimeLayer.stream = sound
	$UpgradeChimeBase.play()
	$UpgradeChimeLayer.play()
	
	
func Flap_Sound():
	var sound = Global.Random_List(flaps)
	$FlappySound.stream = sound
	$FlappySound.play()
	
