extends Node

@onready var gameScene = get_parent()
@onready var propPlaneController = $PropPlaneController
@onready var waveTimer = $Timer
@onready var jetController = $JetController
@onready var jetTimer = $JetTimer
@onready var mossyController = $MosquitoController
@onready var mossyTimer = $MossyTimer
@onready var bossController = $BossController
@onready var cursorController = gameScene.cursorController

var wave = 0
var bossHPX = 1
var bossesSpawned = 0

var jetWaves = []
var bossWaves = []

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
	gameScene.GUI.Update_Wave_Counter(wave)
	if wave in bossWaves:
		gameScene.cursorController.SetBossWave(true)
		gameScene.tipController.Boss_Wave_Tip()
		bossesSpawned += 1
		bossController.Spawn_Boss(bossHPX,bossesSpawned)
#		bossWaves.erase(wave)
		mossyTimer.stop()
	else:
		gameScene.cursorController.SetBossWave(false)
		var propPlaneDifficulty = Wave_Difficulty()
		propPlaneController.Spawn_Props(propPlaneDifficulty)
		mossyTimer.start()
		if wave in jetWaves:
			Jet_Spawn()
			if randf() < .25:
				jetTimer.start()
				
				
func Add_Jet_Waves():
	var x = snapped(randf_range(33,50),1)
	for r in x:
		var j = snapped(randf_range(2,100),1)
		if j not in jetWaves:
			jetWaves.append(j)
	
	
func Add_Boss_Waves(x=0):
	var bossWavePossibilities = [[5,8],[10,13],[15,18],[20,23],[25,28]]
	for p in bossWavePossibilities:
		var p1 = p[0]
		var p2 = p[1]
		var w = (snapped(randf_range(p1,p2),1) + x)
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
