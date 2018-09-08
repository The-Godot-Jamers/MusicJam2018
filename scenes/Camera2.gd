extends Camera

func _ready():
	Globals.camera2 = self

func _process(delta):
	look_at(get_parent().get_node("mainship").translation, Vector3(0.0, 1.0, 0.0))
	