extends Area

onready var main = get_parent().get_node("mainship")
var fixed_trans = Vector3()

var maxhitpoints = 10000
var hitpoints 
var lane_move = 5
var move_speed = 0.6
var can_move = true
var movex 

func _ready():
	fixed_trans = translation
	hitpoints = maxhitpoints

func take_hit(amt):
	$enemy_hit_effect/Particles.emitting = true
	hitpoints -= amt
	$shield.show()
	var color_mod = amt / maxhitpoints
	$shield.get_surface_material(0).albedo_color += Color(color_mod,-color_mod,0,-0.00005)
	$shield/shield_timer.start()
	if hitpoints <= 0:
		visible = false

func _physics_process(delta):
	if $left_area.get_overlapping_areas().size() > 0:
		movex = -lane_move
	elif $right_area.get_overlapping_areas().size() > 0:
		movex = lane_move
	else:
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
	if movex == lane_move:
		$AnimationPlayer.play("bank_left")
	else:
		$AnimationPlayer.play("bank_right")
		

func _on_move_tween_tween_completed(object, key):
	can_move = true

func _on_shield_timer_timeout():
	$shield.hide()



