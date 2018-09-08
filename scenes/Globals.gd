extends Node

var lvl = 0
var lvl1 = preload("res://scenes/mockup.tscn")
var camera1
var camera2
var camera3
var mainship

var songs

func _ready():
	songs = list_files_in_directory("res://music/")
	

func list_files_in_directory(path):
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


func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if lvl == 0:
			get_tree().quit()
		else:
			menu.show()
			get_tree().paused = true

	if lvl != 0:
		if Input.is_action_just_pressed("1"):
			camera1.current = true
		if Input.is_action_just_pressed("2"):
			camera2.current = true
		if Input.is_action_just_pressed("3"):
			camera3.current = true



