extends Camera2D


@export var maxShake : float = 10.0
@export var shakeFade : float = 10.0

var shakeStrength : float = 0.0


func Camera_Shake() -> void:
	shakeStrength = maxShake
	
	
func _process(delta: float) -> void:
	if shakeStrength > 0:
		shakeStrength = lerp(shakeStrength,0.0,shakeFade*delta)
		var randX = randf_range(-shakeStrength,shakeStrength)
		var randY = randf_range(-shakeStrength,shakeStrength)
		offset = Vector2(randX,randY)
