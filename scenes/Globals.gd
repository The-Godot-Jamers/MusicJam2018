extends Node

var lvl = 0
var lvl1 = preload("res://scenes/space_level.tscn")
var camera1
var camera2
var camera3
var mainship
var current_camera

var songs
var extra_songs

func _ready():
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



