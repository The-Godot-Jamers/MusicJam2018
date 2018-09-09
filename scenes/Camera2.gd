extends Camera

var offset 
var shake_offset = Vector3()
var shake = false

func _ready():
	Globals.camera2 = self
	offset = translation

func _process(delta):
	if shake:
		shake_offset = Vector3(rand_range(-5, 5), rand_range(-5, 5), rand_range(-5, 5))
	
	translation = get_parent().get_node("mainship").translation + offset + shake_offset

func _on_shake_timer_timeout():
	shake = false
	shake_offset = Vector3()