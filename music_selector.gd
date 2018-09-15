extends Control



func _ready():
	for i in Globals.songs.size():
		var but = Button.new()
		but.text = Globals.songs[i]
		$center/vbox.add_child(but)
		but.connect("pressed", self, "_select_music")



func _select_music():
	var songs = $center/vbox.get_children()
	var selected 
	for i in songs:
		if i.pressed:
			selected = i.text
	Globals.selected_song = selected
	hide()