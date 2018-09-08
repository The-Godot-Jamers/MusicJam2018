extends Control


func _input(event):
	if Input.is_action_just_pressed("ui_accept") && visible:
		_on_start_pressed()

func _on_start_pressed():
	if Globals.lvl == 0:
		Globals.lvl = 1
		get_tree().change_scene_to(Globals.lvl1)
		$center/vbox/start/center/Label.text = "Resume"
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

