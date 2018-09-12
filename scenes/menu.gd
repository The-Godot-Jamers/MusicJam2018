extends Control

func _ready():
	$center/vbox/start.connect("pressed",self,"_on_start_pressed")
	$center/vbox/options.connect("pressed",self,"_on_options_pressed")
	$center/vbox/quit.connect("pressed",self,"_on_quit_pressed")

func menu_reset():
	$center/vbox/start.text = "Start"
	$menubg.show()
	show()

func _on_start_pressed():
	if Globals.lvl == 0:
		Globals.lvl = 1
		get_tree().change_scene_to(Globals.lvl1)
		$center/vbox/start.text = "Resume"
		$menubg.hide()
	else:
		pass
	get_tree().paused = false
	hide()
	$AudioStreamPlayer.play()

func _on_options_pressed():
	$AudioStreamPlayer.play()

func _on_quit_pressed():
	$AudioStreamPlayer.play()
	get_tree().quit()

