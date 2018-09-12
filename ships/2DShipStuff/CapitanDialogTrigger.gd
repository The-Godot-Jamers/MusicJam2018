extends "DialogTrigger.gd"

func _ready():
	dialog_id = "captian_intro"

func story(dialog_name):
	if dialog_name != dialog_id:
		return
	
	match Ren.story_state:
		"start":
			Ren.say({
				"who":"player",
				"what": "Ahoy! Capitan!"
			})
			Ren.story_state = "cap01"
		
		"cap01":
			Ren.say({
				"who":"captian",
				"what": "Stop screwing around, oficer."
			})
			Ren.story_state = "player01"
		
		"player01":
			Ren.say({
				"who":"player",
				"what": "Yes, Sir!"
			})
			Ren.story_state = "cap02"

		"cap02":
			Ren.say({
				"who":"captian",
				"what": "Seriously! Any way go and talk with that alien."
			})
			Ren.story_state = "exit_dialog"
		
		"exit_dialog":
			Window.hide()
