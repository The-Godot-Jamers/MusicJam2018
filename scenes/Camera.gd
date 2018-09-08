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
#	translation = get_parent().get_node("mainship").translation + Vector3(0.0, 20.0, -15.0)
	#look_at(get_parent().get_node("mainship").translation,Vector3(0.0, 1.0,0.0))
	
	translation = get_parent().get_node("mainship").translation + offset + shake_offset

func _on_shake_timer_timeout():
	shake = false
	shake_offset = Vector3()
