extends Node

@onready var gameScene = get_parent()
@onready var propPlaneController = $PropPlaneController
@onready var waveTimer = $Timer
@onready var jetController = $JetController
@onready var jetTimer = $JetTimer
@onready var mossyController = $MosquitoController
@onready var mossyTimer = $MossyTimer
@onready var bossController = $BossController

var wave = 0
var bossHPX = 1

var jetWaves = []
var bossWaves = [10,11,12]


func _ready():
	Add_Jet_Waves()
	Add_Boss_Waves()
			
func Wave_Difficulty():
	if wave < 5:
		return randf_range(4,7)
	elif wave == 6:
		return 0
	elif wave < 9:
		return randf_range(6,10)
	elif wave < 15:
		return randf_range(9,15)
	else:
		return randf_range(14,25)
		
func Next_Wave():
	wave += 1
	if wave in bossWaves:
		bossController.Spawn_Boss(bossHPX)
#		bossWaves.erase(wave)
		mossyTimer.stop()
	else:
		var propPlaneDifficulty = Wave_Difficulty()
		propPlaneController.Spawn_Props(propPlaneDifficulty)
		mossyTimer.start()
		if wave in jetWaves:
			Jet_Spawn()
			if randf() < .25:
				jetTimer.start()
func Add_Jet_Waves():
	var x = snapped(randf_range(25,50),1)
	for r in x:
		var j = snapped(randf_range(2,100),1)
		if j not in jetWaves:
			jetWaves.append(j)
	
	
func Add_Boss_Waves():
	var bossWavePossibilities = [[3,6],[8,11],[14,17],[20,23],[27,30]]
	for p in bossWavePossibilities:
		var p1 = p[0]
		var p2 = p[1]
		var w = snapped(randf_range(p1,p2),1)
		bossWaves.append(w)
	
	
func _on_timer_timeout():
	Next_Wave()

func Jet_Spawn():
	jetController.Plane_Spawn()

func _on_jet_timer_timeout():
	jetController.Plane_Spawn()


func _on_mossy_timer_timeout():
	mossyController.Spawn_Mossies()
	mossyTimer.wait_time = randf_range(3.0,8.0)
