class_name SaverLoader
extends Node




func Save_Game():
	
	var savedGame:SavedGame = SavedGame.new()
	
	savedGame.highScore = Global.playerStats["High Score"]
	savedGame.lifetimeScore = Global.playerStats["Lifetime Score"]
	savedGame.lifetimeMossies = Global.playerStats["Lifetime Mosquitos"]
	#savedGame.critChance = Global.playerStats["Crit Chance"]
	
	savedGame.mossiesInStock = Global.mossiesInStock
	
	savedGame.currentBird = Global.currentBird
	savedGame.currentBird1 = Global.currentBird1
	savedGame.currentBird2 = Global.currentBird2
	savedGame.currentBird3 = Global.currentBird3

	for s in Global.birdUnlocks:
		if Global.birdUnlocks[s]:
			savedGame.birdUnlocks[s] = Global.birdUnlocks[s]
			
	for s in Global.upgrades:
		savedGame.upgrades[s] = Global.upgrades[s]
		
	for s in Global.tipTriggers:
		savedGame.tips[s] = Global.tipTriggers[s]


	savedGame.masterVolume = Global.masterVolume
	savedGame.musicVolume = Global.musicVolume
	savedGame.sfxVolume = Global.sfxVolume
	
	ResourceSaver.save(savedGame, "user://savegame.tres")
	
func Load_Game():
	var savedGame:SavedGame = load("user://savegame.tres") as SavedGame
	var savePath = "user://savegame.tres"


	if ResourceLoader.exists(savePath):
		Global.playerStats["High Score"] = savedGame.highScore
		Global.playerStats["Lifetime Score"] = savedGame.lifetimeScore
		Global.playerStats["Lifetime Mosquitos"] = savedGame.lifetimeMossies
		#Global.playerStats["Crit Chance"] = savedGame.critChance
		
		Global.mossiesInStock = savedGame.mossiesInStock
#

		Global.currentBird = savedGame.currentBird
		Global.currentBird1 = savedGame.currentBird1
		Global.currentBird2 = savedGame.currentBird2
		Global.currentBird3 = savedGame.currentBird3

		for s in savedGame.birdUnlocks:
			Global.birdUnlocks[s] = savedGame.birdUnlocks[s]

		for s in savedGame.upgrades:
			Global.upgrades[s] = savedGame.upgrades[s]
			
		for s in savedGame.tips:
			Global.tipTriggers[s] = savedGame.tips[s]
			
		Global.masterVolume = savedGame.masterVolume
		Global.musicVolume = savedGame.musicVolume
		Global.sfxVolume = savedGame.sfxVolume
