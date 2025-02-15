extends HSlider

@export var busName: String
var busIndex: int
var volume = value


func _ready():
	busIndex = AudioServer.get_bus_index(busName)
	value_changed.connect(On_Value_Changed)
	
	#value = db_to_linear(
	#	AudioServer.get_bus_volume_db(busIndex)
	#)
	
	
func On_Value_Changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		busIndex,
		linear_to_db(value)
	)
	if busName == "Master":
		Global.masterVolume = self.value
	elif busName == "Music":
		Global.musicVolume = self.value
	elif busName == "SFX":
		Global.sfxVolume = self.value
