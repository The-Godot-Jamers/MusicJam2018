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
	Globals._set_lvl(1)
	if get_parent().is_in_group("menu"):
		get_parent().skip_intro()
	get_tree().change_scene_to(Globals.lvl1)