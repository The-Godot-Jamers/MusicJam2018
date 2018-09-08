extends Camera

var offset 
var shake_offset = Vector3()
var shake = false


func start_shake():
	shake = true
	$shake_timer.start()

func _ready():
	Globals.camera1 = self
	offset = translation

func _process(delta):
	if shake:
		shake_offset = Vector3(rand_range(-3, 3), rand_range(-3, 3), rand_range(-3, 3))
	$camera_tween.interpolate_property(self, "translation", translation, get_parent().get_node("mainship").translation + offset + shake_offset, 0.3, Tween.TRANS_SINE, Tween.EASE_OUT)
	$camera_tween.start()
	
	#translation = get_parent().get_node("mainship").translation + offset + shake_offset

func _on_shake_timer_timeout():
	shake = false
	shake_offset = Vector3()
