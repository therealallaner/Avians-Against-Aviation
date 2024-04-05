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

var jetWaves = [4,6,8,10,12,13,14,15,16]
var bossWaves = []


func _ready():
	for x in range(snapped(randf_range(5,10),1)):
		var w = snapped(randf_range(5,40),1)
		if w not in bossWaves:
			bossWaves.append(int(w))
			
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
	print(wave)
	wave += 1
	if wave in bossWaves:
		bossController.Spawn_Boss(bossHPX)
		bossWaves.erase(wave)
		mossyTimer.stop()
	else:
		var propPlaneDifficulty = Wave_Difficulty()
		propPlaneController.Spawn_Props(propPlaneDifficulty)
		mossyTimer.start()
		if wave in jetWaves:
			jetController.Plane_Spawn()
			if randf() < .25:
				jetTimer.start()


func _on_timer_timeout():
	Next_Wave()


func _on_jet_timer_timeout():
	jetController.Plane_Spawn()


func _on_mossy_timer_timeout():
	mossyController.Spawn_Mossies()
	mossyTimer.wait_time = randf_range(3.0,8.0)
