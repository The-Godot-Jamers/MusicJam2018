extends Spatial

var lane_offset = 2.5
var lane_spacing = 5.0
var asteroid = preload("res://scenes/asteroid.tscn")
var shooting_star = preload("res://scenes/shooting_star.tscn")
var m = SpatialMaterial.new()
onready var im = get_node("lanes") #ImmediateGeometry

func _ready():
	m.flags_unshaded = true
	m.flags_use_point_size = true
	m.albedo_color = Color(0.4, 0.1, 0.5, 1.0)
	m.metallic = 0.5
	m.emission_enabled = true
	m.emission = Color(0.4, 0.1, 0.5, 1.0)
	create_lanes()

func create_lanes():
	im.clear()
	im.set_material_override(m)
	for i in 12:
		im.begin(Mesh.PRIMITIVE_LINES)
		im.add_vertex(Vector3($mainship.translation.x, 0.0, 0.0) + Vector3(lane_offset + (i * lane_spacing),0.0,-100.0))
		im.add_vertex(Vector3($mainship.translation.x, 0.0, 0.0) + Vector3(lane_offset + (i * lane_spacing),0.0,100.0))
		im.end()
	for z in 12:
		im.begin(Mesh.PRIMITIVE_LINES)
		im.add_vertex(Vector3($mainship.translation.x, 0.0, 0.0) + Vector3(lane_offset + (-z * lane_spacing),0.0,-100.0))
		im.add_vertex(Vector3($mainship.translation.x, 0.0, 0.0) + Vector3(lane_offset + (-z * lane_spacing),0.0,100.0))
		im.end()

func create_asteroid(pos):
	var aster = asteroid.instance()
	aster.translation = Vector3()
	aster.translation.z = 150
	aster.translation.x = (round($mainship.translation.x/5) * 5) + (lane_spacing * pos)
	add_child(aster)

func create_shooting_star(posx,posy):
	var star = shooting_star.instance()
	star.translation = Vector3()
	star.translation.z = 150
	star.translation.x = $mainship.translation.x + (posx * lane_spacing)
	star.translation.y = posy + 5
	add_child(star)
func _on_asteroid_timer_timeout():
	create_asteroid(round(rand_range(-10,10)))

func _on_shooting_star_timer_timeout():
	create_shooting_star(round(rand_range(-10,10)),round(rand_range(0,8)))
	
func player_dead():
	get_tree().change_scene_to(load("res://scenes/splash.tscn"))
	Globals.lvl = 0
	menu.menu_reset()

func enemy_killed():
	pass

