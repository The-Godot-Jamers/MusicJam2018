extends KinematicBody

onready var main = get_parent().get_node("mainship")
var fixed_trans = Vector3()

func _ready():
	fixed_trans = translation

func take_hit():
	pass