extends Area


var begin = Vector3(0.0,0,0)
var end = Vector3(0,0,15)
var m = SpatialMaterial.new()
onready var im = get_node("draw") #ImmediateGeometry
var lane_move = 5
var move_speed = 0.6
var can_move = true

func _ready():
	Globals.mainship = self
	#Colors for immediategeometry
	m.flags_unshaded = true
	m.flags_use_point_size = true
	m.albedo_color = Color(1.0, 0.0, 0.0, 1.0)

func _input(event):
	if Input.is_action_just_pressed("left") && can_move:
		$move_tween.interpolate_property(self,"translation",translation,translation + Vector3(lane_move,0.0,0.0),move_speed,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
		$move_tween.start()
		can_move = false
	if Input.is_action_just_pressed("right") && can_move:
		$move_tween.interpolate_property(self,"translation",translation,translation + Vector3(-lane_move,0.0,0.0),move_speed,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
		$move_tween.start()
		can_move = false
	
	if Input.is_action_pressed("shoot"):
		shoot()
	else:
		im.clear() #clear the laser if not shooting

func shoot():
	im.set_material_override(m)
	im.begin(Mesh.PRIMITIVE_LINES)
	im.add_vertex(begin)
	im.add_vertex(end)
	im.end()

func _on_move_tween_tween_completed(object, key):
	can_move = true
	$lane_timer.start()

func take_hit():
	$hit_effect.parts.emitting = true

func _on_lane_timer_timeout():
	get_parent().create_lanes()
	
