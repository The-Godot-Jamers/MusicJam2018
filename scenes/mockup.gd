extends Spatial

var lane_offset = 2.5
var lane_spacing = 5.0
var asteroid = preload("res://scenes/asteroid.tscn")
var m = SpatialMaterial.new()
onready var im = get_node("lanes") #ImmediateGeometry

func _ready():
	m.flags_unshaded = true
	m.flags_use_point_size = true
	m.albedo_color = Color(1.0, 0.0, 0.0, 1.0)
	create_lanes()

func create_lanes():
	im.clear()
	im.set_material_override(m)
	for i in 10:
		im.begin(Mesh.PRIMITIVE_LINES)
		im.add_vertex(Vector3($mainship.translation.x, 0.0, 0.0) + Vector3(lane_offset + (i * lane_spacing),0.0,-100.0))
		im.add_vertex(Vector3($mainship.translation.x, 0.0, 0.0) + Vector3(lane_offset + (i * lane_spacing),0.0,100.0))
		im.end()
	for z in 10:
		im.begin(Mesh.PRIMITIVE_LINES)
		im.add_vertex(Vector3($mainship.translation.x, 0.0, 0.0) + Vector3(lane_offset + (-z * lane_spacing),0.0,-100.0))
		im.add_vertex(Vector3($mainship.translation.x, 0.0, 0.0) + Vector3(lane_offset + (-z * lane_spacing),0.0,100.0))
		im.end()

func _on_asteroid_timer_timeout():
	var aster = asteroid.instance()
	aster.translation = Vector3()
	aster.translation.z = 500
	aster.translation.x = rand_range($mainship.translation.x -50, $mainship.translation.x +50)
	add_child(aster)
