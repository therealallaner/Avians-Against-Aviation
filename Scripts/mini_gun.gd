extends AudioStreamPlayer2D


@onready var gunShot1 = preload("res://Assets/SFX/MiniGun Sounds/ES_Designed, Assault Rifle, Fire, Single Shot - Epidemic Sound - 0000-0244.wav")
@onready var gunShot2 = preload("res://Assets/SFX/MiniGun Sounds/ES_Designed, Assault Rifle, Fire, Single Shot - Epidemic Sound - 1175-1518.wav")
@onready var gunShot3 = preload("res://Assets/SFX/MiniGun Sounds/ES_Designed, Assault Rifle, Fire, Single Shot - Epidemic Sound - 2391-2682.wav")
@onready var gunShot4 = preload("res://Assets/SFX/MiniGun Sounds/ES_Designed, Assault Rifle, Fire, Single Shot - Epidemic Sound - 3599-3913.wav")
@onready var shots = [gunShot1,gunShot2,gunShot3,gunShot4]



func _ready():
	stream = Global.Random_List(shots)
	self.play()


func _process(delta):
	if !self.playing:
		queue_free()
