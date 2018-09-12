extends Area

var hitpoints = 3
var begin = Vector3(0.0,0,0)
var end = Vector3(0,0,15)
var m = SpatialMaterial.new()
onready var im = get_node("draw") #ImmediateGeometry
var lane_move = 5
var move_speed = 0.6
var can_move = true
var is_shooting = false

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
		$AnimationPlayer.play("bank_left")
	if Input.is_action_just_pressed("right") && can_move:
		$move_tween.interpolate_property(self,"translation",translation,translation + Vector3(-lane_move,0.0,0.0),move_speed,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
		$move_tween.start()
		can_move = false
		$AnimationPlayer.play("bank_right")
	
	if Input.is_action_pressed("shoot"):
		is_shooting = true
	else:
		is_shooting = false
		im.clear() #clear the laser if not shooting

func _physics_process(delta):
	if is_shooting: 
		shoot()


func shoot():
	if $shooting_ray.is_colliding():
		#end = $shooting_ray.get_collision_point()
		var hit = $shooting_ray.get_collider()
		var bus = AudioServer.get_bus_index("Master")
		hit.take_hit(abs((AudioServer.get_bus_peak_volume_left_db(bus,0) + AudioServer.get_bus_peak_volume_right_db(bus,0)) / 2) / 5)
	else:
		end = Vector3(0,0,15)
	im.set_material_override(m)
	im.begin(Mesh.PRIMITIVE_LINES)
	im.add_vertex(begin)
	im.add_vertex(end)
	im.end()

func _on_move_tween_tween_completed(object, key):
	can_move = true
	$lane_timer.start()

func take_hit(amt):
	Globals.camera1.start_shake()
	$hit_effect.parts.emitting = true
	hitpoints -= 1
	if hitpoints == 0:
		get_parent().player_dead()

func _on_lane_timer_timeout():
	get_parent().create_lanes()
	
