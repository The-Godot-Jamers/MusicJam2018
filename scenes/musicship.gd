extends Area

onready var main = get_parent().get_node("mainship")
var fixed_trans = Vector3()

var lane_move = 5
var move_speed = 0.6
var can_move = true
var movex 

func _ready():
	fixed_trans = translation

func take_hit():
	pass

func _physics_process(delta):
	if randf() > 0.5:
		movex = lane_move
	else:
		movex = -lane_move
	if $back_area.get_overlapping_areas().size() > 0 && can_move:
		$move_tween.interpolate_property(self,"translation",translation,translation + Vector3(movex,0.0,0.0),move_speed,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
		start_move()
	if $center_area.get_overlapping_areas().size() > 0 && can_move:
		$move_tween.interpolate_property(self,"translation",translation,translation + Vector3(movex,0.0,0.0),move_speed,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
		start_move()

func start_move():
	$move_tween.start()
	can_move = false
	

func _on_move_tween_tween_completed(object, key):
	can_move = true
