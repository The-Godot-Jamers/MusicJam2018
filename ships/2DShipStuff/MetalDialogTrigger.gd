extends "DialogTrigger.gd"

func _ready():
	dialog_id = "metal_dialog"

func story(dialog_name):
	if dialog_name != dialog_id:
		return
	
	if not Globals.after_intro:
		intro()
		return

	match Ren.story_state:
		"start":
			Ren.say({
				"who":"metal",
				"what": "You ready for some PVP?"
			})
			Ren.story_state = "exit_dialog"
		
		"exit_dialog":
			Window.hide()

func intro():
	match Ren.story_state:
		"start":
			Ren.say({
				"who":"metal",
				"what": "You ready for some PVP?"
			})
			Ren.story_state = "player01"
		
		"player01":
			Ren.say({
				"who":"player",
				"what": "Yeah, but I 'd rather go against some AI bots."
			})
			Ren.story_state = "metal01"

		
		"metal01":
			Ren.say({
				"who":"metal",
				"what": "Sorry, system is down, we're getting a programmer to work on that, but for now, you'll have to go against me. Ready?"
			})
			Ren.story_state = "player02"
		
		
		"player02":
			Ren.say({
				"who":"captain",
				"what": "Huh, sure?"
			})
			Ren.story_state = "metal02"

		"metal02":
			Ren.say({
				"who":"metal",
				"what": "Wow, sounds like someone's balls just dropped pilot. I know people call me the Metal Witch, but would rather train with someone who kills or get's killed."
			})
			Ren.story_state = "exit_dialog"
		
		"exit_dialog":
			Window.hide()
