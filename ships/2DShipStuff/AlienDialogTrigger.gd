extends "DialogTrigger.gd"

func _ready():
	dialog_id = "alien_intro"

func story(dialog_name):
	if dialog_name != dialog_id:
		return
	
	match Ren.story_state:
		"start":
			Ren.say({
				"who":"player",
				"what": "Do you have quest for me?"
			})
			Ren.story_state = "alien01"
		
		"alien01":
			Ren.say({
				"who":"alien",
				"what": "UGBnnmbhjmjIUTYgjh1278"
			})
			Ren.story_state = "player01"
		
		"player01":
			Ren.say({
				"who":"player",
				"what": "Wait. I forrgot to turn on my translator module."
			})
			Ren.story_state = "player02"

		"player02":
			Ren.say({
				"who":"player",
				"what": "Ok, It is working now."
			})
			Ren.story_state = "alien02"

		"alien02":
			Ren.say({
				"who":"alien",
				"what": "I have epic Quest for you ..."
			})
			## add more story
			Ren.story_state = "exit_dialog"
		
		"exit_dialog":
			Window.hide()