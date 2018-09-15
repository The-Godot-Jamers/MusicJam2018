extends AudioStreamPlayer

var song = 0

func _ready():
	if Globals.selected_song != null:
		change_music(Globals.selected_song)
	else:
		get_parent().get_node("visualiser").set_music(stream)
		play()

func change_music(music):
	stream = load("res://music/%s" % music)
	get_parent().get_node("visualiser").set_music(stream)
	play()
	print(stream)
	if song < Globals.songs.size()-1:
		song += 1
	else:
		song = 0

func _input(event):
	if Input.is_action_just_pressed("ui_focus_next"):
		change_music(Globals.songs[song])


func _process(delta):
	if not is_playing():
		change_music(Globals.songs[song])
	