extends Control

var intro = true

func _ready():
	$center/vbox/start.connect("pressed",self,"_on_start_pressed")
<<<<<<< HEAD
	$center/vbox/intro.connect("pressed",self,"_on_intro_pressed")
=======
#	$center/vbox/options.connect("pressed",self,"_on_options_pressed")
>>>>>>> 0ffd9a98a844a0903742db9c3ffff1ae1760316f
	$center/vbox/quit.connect("pressed",self,"_on_quit_pressed")

func menu_reset():
	$center/vbox/start.text = "Start"
	$menubg.show()
	show()

func show_bg():
	$menubg.show()

func _on_start_pressed():
	if Globals.lvl == 0:
		if intro:
			Globals.lvl = -1
			get_tree().change_scene_to(Globals.intro)
			$menubg.hide()
			get_tree().paused = false
			hide()
		else:
			
			$center/vbox.hide()
			$music_selector.show()
			raise()
		$center/vbox/start.text = "Resume"
	$AudioStreamPlayer.play()

func _on_intro_pressed():
	$AudioStreamPlayer.play()
	intro = !intro
	$center/vbox/intro.modulate.r = 1-$center/vbox/intro.modulate.r
	$center/vbox/intro.modulate.g = 1-$center/vbox/intro.modulate.g

func _on_quit_pressed():
	$AudioStreamPlayer.play()
	get_tree().quit()

