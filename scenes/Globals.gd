extends Node

var lvl = 0 setget _set_lvl, _get_lvl
var _lvl
var lvl1 = preload("res://scenes/space_level.tscn")
var intro = preload("res://scenes/ShipDeck.tscn")
var camera1
var camera2
var camera3
var mainship
var current_camera
var warranty_color = Color()
var after_intro = false
var _after_intro
var songs
var extra_songs
var selected_song = null
var asteroids = []
var talking = false setget _set_talking, _get_talking
var _talking

var colors = ["#472D3C","#7A444A","A05B53","BF7958","EEA160","FFFDAF","B6D53C",
				"71AA34","397B44","3C5956","302C2E", "5A5353","7D7071",
				"A0938E","CFC6B8","DFF6F5","8AEBF1","00FAAC","3978A8","39314B",
				"564064","302387","FF3796","FFAEB6","F4B41B","F47E1B","E6482E",
				"A93B3B","827094","4F546B"]


func _ready():
	Ren.define("lvl", 0)
	Ren.define("after_intro", false)
	Ren.define("talking", false)
	randomize()
	make_asteroid_shapes()
	songs = list_basic_music("res://music/")
	#not yet working properly
#	extra_songs = list_extra_music(ProjectSettings.globalize_path("res://extra_music"))
#	if extra_songs.size() > 0:
#		for i in extra_songs:
#			print("add song ", extra_songs[i])
#			songs.append(extra_songs[i])
#	print(songs)

func list_basic_music(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and file.ends_with(".import"):
			file = file.replace(".import", "")
			files.append(file)
	dir.list_dir_end()
	return files

#not yet working
#func list_extra_music(path):
#	var music = []
#	var dir = Directory.new()
#	dir.open(path)
#	dir.list_dir_begin()
#	print("path ", path)
#	while true:
#		var file = dir.get_next()
#		if file == "":
#			break
#		elif not file.begins_with(".") and (file.ends_with(".ogg")):
#			var song = File.new()
#			song.open(file, File.READ)
#			print("file ", file)
#			print("song ", song)
#			var bytes = song.get_buffer(song.get_len())
#			print("bytes ", bytes)
#			var stream = AudioStreamOGGVorbis.new()
#			stream.data = bytes
#			music.append(stream)
#			song.close()
#	dir.list_dir_end()
#	return music

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if lvl == 0:
			get_tree().quit()
		else:
			menu.show()
			menu.raise()
			get_tree().paused = true
			if lvl <= 0:
				menu.show_bg()
#
	if lvl >= 0:
		if Input.is_action_just_pressed("1"):
			camera1.current = true
			current_camera = camera1
		if Input.is_action_just_pressed("2"):
			camera2.current = true
			current_camera = camera2
#		if Input.is_action_just_pressed("3"):
#			camera3.current = true
	if Input.is_action_just_pressed("ui_focus_prev"):
		get_tree().change_scene_to(lvl1)

func _set_lvl(value):
	_lvl = value
	Ren.define("lvl", value)

func _get_lvl():
	if Ren.get_value("lvl") != null:
		_lvl = Ren.get_value("lvl")
	return _lvl

func _set_after_intro(value):
	_after_intro = value
	Ren.define("after_intro", value)

func _get_after_intro():
	if Ren.get_value("after_intro") != null:
		_after_intro = Ren.get_value("after_intro")
	return _after_intro

func make_asteroid_shapes():
	for i in 4:
		var surf = MeshDataTool.new()
		surf.create_from_surface($asteroid_test/Planet.mesh, 0)
		
		
		var max_iterations = 30  
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
		asteroids.append(mmesh)

func _set_talking(value):
	_talking = value
	Ren.define("talking", value)

func _get_talking():
	if Ren.get_value("talking") != null:
		_talking = Ren.get_value("talking")
	return _talking
