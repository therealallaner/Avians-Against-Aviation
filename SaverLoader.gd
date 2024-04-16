class_name SaverLoader
extends Node




func Save_Game():
	
	var savedGame:SavedGame = SavedGame.new()
	
	savedGame.highScore = Global.playerStats["High Score"]
	savedGame.lifetimeScore = Global.playerStats["Lifetime Score"]
	savedGame.lifetimeMossies = Global.playerStats["Lifetime Mosquitos"]
	savedGame.critChance = Global.playerStats["Crit Chance"]
	savedGame.mossiesInStock1 = Global.mossiesInStock1
	savedGame.mossiesInStock2 = Global.mossiesInStock2
	savedGame.mossiesInStock3 = Global.mossiesInStock3
	
	savedGame.currentBird = Global.currentBird
	savedGame.currentBird1 = Global.currentBird1
	savedGame.currentBird2 = Global.currentBird2
	savedGame.currentBird3 = Global.currentBird3

	for s in Global.birdUnlocks1:
		if Global.birdUnlocks1[s]:
			savedGame.birdUnlocks1[s] = Global.birdUnlocks1[s]
	for s in Global.birdUnlocks2:
		if Global.birdUnlocks2[s]:
			savedGame.birdUnlocks2[s] = Global.birdUnlocks2[s]
	for s in Global.birdUnlocks3:
		if Global.birdUnlocks3[s]:
			savedGame.birdUnlocks3[s] = Global.birdUnlocks3[s]
			
			
	savedGame.masterVolume = Global.masterVolume
	savedGame.musicVolume = Global.musicVolume
	
	ResourceSaver.save(savedGame, "user://savegame.tres")
	
func Load_Game():
	var savedGame:SavedGame = load("user://savegame.tres") as SavedGame
	var savePath = "user://savegame.tres"


	if ResourceLoader.exists(savePath):
		Global.playerStats["High Score"] = savedGame.highScore
		Global.playerStats["Lifetime Score"] = savedGame.lifetimeScore
		Global.playerStats["Lifetime Mosquitos"] = savedGame.lifetimeMossies
		Global.playerStats["Crit Chance"] = savedGame.critChance
		Global.mossiesInStock1 = savedGame.mossiesInStock1
		Global.mossiesInStock2 = savedGame.mossiesInStock2
		Global.mossiesInStock3 = savedGame.mossiesInStock3
#@export var highScore: int
#@export var mossiesInStock1: int
#@export var mossiesInStock2: int
#@export var mossiesInStock3: int
#

		Global.currentBird = savedGame.currentBird
		Global.currentBird1 = savedGame.currentBird1
		Global.currentBird2 = savedGame.currentBird2
		Global.currentBird3 = savedGame.currentBird3
#@export var currentBird: String
#@export var currentBird1: String
#@export var currentBird2: String
#@export var currentBird3: String
#

		for s in savedGame.birdUnlocks1:
			Global.birdUnlocks1[s] = savedGame.birdUnlocks1[s]
		for s in savedGame.birdUnlocks2:
			Global.birdUnlocks2[s] = savedGame.birdUnlocks2[s]
		for s in savedGame.birdUnlocks3:
			Global.birdUnlocks3[s] = savedGame.birdUnlocks3[s]
			
#@export var birdUnlocks1: Dictionary
#@export var birdUnlocks2: Dictionary
#@export var birdUnlocks3: Dictionary

		Global.masterVolume = savedGame.masterVolume
		Global.musicVolume = savedGame.musicVolume
