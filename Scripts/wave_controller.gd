extends Node

@onready var propPlaneController = $PropPlaneController
@onready var waveTimer = $Timer

var wave = 0


func Wave_Difficulty():
	if wave < 5:
		return randf_range(4,7)
	elif wave < 9:
		return randf_range(6,10)
	elif wave < 15:
		return randf_range(9,15)
	else:
		return randf_range(14,25)
		
func Next_Wave():
	wave += 1
	var propPlaneDifficulty = Wave_Difficulty()
	propPlaneController.Spawn_Props(propPlaneDifficulty)


func _on_timer_timeout():
	Next_Wave()
