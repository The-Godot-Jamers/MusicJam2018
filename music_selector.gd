extends Control



func _ready():
	for i in Globals.songs.size():
		var but = Button.new()
		but.text = Globals.songs[i]
		$center/vbox.add_child(but)
		
	for i in $center/vbox.get_children().size():
		var b = get_child(i)
		b.connect("pressed", self, "select_music")
		print(b.is_connected("pressed", self, "selec_music"))
		


func select_music(selected):
	print(selected)