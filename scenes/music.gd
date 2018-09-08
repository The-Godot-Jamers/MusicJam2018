extends AudioStreamPlayer

var song = 0

func _ready():
	#AudioServer.set_bus_layout(load("res://default_bus_layout.tres"))
	get_parent().get_node("visualiser").set_music(stream)

func change_music(music):
	stream = load("res://music/%s" % music)
	get_parent().get_node("visualiser").set_music(stream)


func _input(event):
	if Input.is_action_just_pressed("ui_focus_next"):
		change_music(Globals.songs[song])	
		print(Globals.songs[song])
		if song < Globals.songs.size()-1:
			song += 1
		else:
			song = 0