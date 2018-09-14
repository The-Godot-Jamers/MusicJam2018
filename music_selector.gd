extends Control


func _ready():
	for i in Globals.songs.size():
		var but = Button.new()
		$center/vbox.add_child(but)
		but.text = Globals.songs[i]
		but.connect("toggled", self, "select_music")

func select_music(selected):
	print(selected)