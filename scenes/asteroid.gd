extends Area

export var speed = 1
var minz = -50
var base_scale = Vector3()
var base_albedo = Vector3()
var mat 

func _ready():
	base_scale = scale
	mat = $MeshInstance.get_surface_material(0)
	base_albedo = mat.albedo_color

func set_albedo(albedo):
	base_albedo = albedo

func set_mesh(mesh):
	$MeshInstance.mesh = mesh

func set_surface(surf):
	$MeshInstance.set_surface_material(0,surf)
	mat = surf 

func _physics_process(delta):
	#movement
	translation.z -= speed
	
	if translation.z < minz:
		queue_free()

func _process(delta):
	#music scaling
	var bus = AudioServer.get_bus_index("Master")
	var scale_mod = abs(((AudioServer.get_bus_peak_volume_left_db(bus,0) + AudioServer.get_bus_peak_volume_right_db(bus,0)) / 2) / 50)
	scale_mod = 1 - scale_mod
	$MeshInstance.scale = base_scale + Vector3(scale_mod, scale_mod, scale_mod)
	$CollisionShape.scale = base_scale + Vector3(scale_mod, scale_mod, scale_mod)
	#music colors
	bus = AudioServer.get_bus_index("1")
	scale_mod = abs(((AudioServer.get_bus_peak_volume_left_db(bus,0) + AudioServer.get_bus_peak_volume_right_db(bus,0)) / 2) / 100)
	mat.albedo_color.r = scale_mod
	bus = AudioServer.get_bus_index("3")
	scale_mod = abs(((AudioServer.get_bus_peak_volume_left_db(bus,0) + AudioServer.get_bus_peak_volume_right_db(bus,0)) / 2) / 100)
	mat.albedo_color.g = scale_mod
	bus = AudioServer.get_bus_index("6")
	scale_mod = abs(((AudioServer.get_bus_peak_volume_left_db(bus,0) + AudioServer.get_bus_peak_volume_right_db(bus,0)) / 2) / 100)
	mat.albedo_color.b = scale_mod

func _on_asteroid_body_entered(body):
	body.take_hit()


func _on_asteroid_area_entered(area):
	area.take_hit(1)