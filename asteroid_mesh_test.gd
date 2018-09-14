extends Spatial


func _ready():
	Globals.lvl = 5
	#print($Planet.mesh.surface_get_material(0))
	#$Planet.mesh.surface_get_material(0).set_shader_param("rand_seed", rand_range(0.1,0.9))
	make_asteroid_shape()
	

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		#make_asteroid_shape()
		pass

func make_asteroid_shape():
		
	var surf = MeshDataTool.new()
	surf.create_from_surface($Planet.mesh, 0)
	
	
	var max_iterations = 80  
	for j in range(max_iterations):
		
		# wait a frame to prevent freezing the game
		yield(get_tree(), "idle_frame")
		
		var dir = Vector3(rand_range(-1,1), rand_range(-1,1), rand_range(-1,1)).normalized()
		
		# push/pull all vertices (this is the slow part)
		for i in range(surf.get_vertex_count()):
			var v = surf.get_vertex(i)
			var norm = surf.get_vertex_normal(i)
			
			var dot = norm.normalized().dot(dir)
			var sharpness = 60  
			dot = exp(dot*sharpness) / (exp(dot*sharpness) + 1) - 0.5 # sigmoid function
			
			v += dot * norm * 0.01
			
			surf.set_vertex(i, v)
			
	#also recalculate face normals (TODO smooth 'em!)
	
	for i in range(surf.get_face_count()):
		
		var v1i = surf.get_face_vertex(i,0)
		var v2i = surf.get_face_vertex(i,1)
		var v3i = surf.get_face_vertex(i,2)
		
		var v1 = surf.get_vertex(v1i)
		var v2 = surf.get_vertex(v2i)
		var v3 = surf.get_vertex(v3i)
		
		# calculate normal for this face
		var norm = -(v2 - v1).normalized().cross((v3 - v1).normalized()).normalized()
		
		surf.set_vertex_normal(v1i, norm)
		surf.set_vertex_normal(v2i, norm)
		surf.set_vertex_normal(v3i, norm)
	
	# commit the mesh
	var mmesh = ArrayMesh.new() 
	surf.commit_to_surface(mmesh)
	print(mmesh.get_faces().size())
	$Planet.mesh = mmesh
	

