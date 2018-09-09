extends Spatial

export var speed = 1 
var minz = -50

func _ready():
	speed = speed + rand_range(-0.1, 0.1)

func _physics_process(delta):
	#movement
	translation.z -= speed
	if translation.z < minz:
		queue_free()