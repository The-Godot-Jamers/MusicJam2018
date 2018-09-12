extends Node

var lvl = 0 setget _set_lvl, _get_lvl
var _lvl
var lvl1 = preload("res://scenes/space_level.tscn")
var camera1
var camera2
var camera3
var mainship
var current_camera
var warranty_color = Color()

var songs
var extra_songs

var colors = ["#472D3C","#7A444A","A05B53","BF7958","EEA160","FFFDAF","B6D53C","71AA34","397B44","3C5956","302C2E", "5A5353","7D7071",
				"A0938E","CFC6B8","DFF6F5","8AEBF1","00FAAC","3978A8","39314B","564064","302387","FF3796","FFAEB6","F4B41B","F47E1B","E6482E","A93B3B","827094","4F546B"]


func _ready():
	Ren.define("lvl", 0)
	randomize()
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
			get_tree().paused = true
#
	if lvl != 0:
		if Input.is_action_just_pressed("1"):
			camera1.current = true
			current_camera = camera1
		if Input.is_action_just_pressed("2"):
			camera2.current = true
			current_camera = camera2
#		if Input.is_action_just_pressed("3"):
#			camera3.current = true

func _set_lvl(value):
	_lvl = value
	lvl = _lvl 
	Ren.define("lvl", value)

func _get_lvl():
	if Ren.get_value("lvl") != null:
		_lvl = Ren.get_value("lvl")
	return _lvl

