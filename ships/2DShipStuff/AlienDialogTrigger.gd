extends "DialogTrigger.gd"

func _ready():
	dialog_id = "alien_dialog"

func story(dialog_name):
	if dialog_name != dialog_id:
		return
	
	if not Globals.after_intro:
		Globals.talking = true
		intro()
		Window.show()
		return
	

	match Ren.story_state:
		"start":
			Globals.talking = true
			Ren.say({
				"who":"alien",
				"what": "Hey check out the bounties and music in the brig. It should help."
			})
			Ren.story_state = "exit_dialog"
			Window.show()
		
		"exit_dialog":
			Globals.talking = false
			Window.hide()


func intro():
	match Ren.story_state:
		"start":
			Ren.say({
				"who":"player",
				"what": "Are you okay?"
			})
			Ren.story_state = "alien01"
		
		"alien01":
			Ren.say({
				"who":"alien",
				"what": "It's hard for my people to be separated from their colony, their queen, their purpose for a long period of time."
			})
			Ren.story_state = "player01"
		
		"player01":
			Ren.say({
				"who":"Player",
				"what": "I'm glad we found you when we did, we have a chance to save humanity, and help your people and mine rebuild."
			})
			Ren.story_state = "alien02"

		"alien02":
			Ren.say({
				"who":"alien",
				"what": "Yes, we may have different music, but music is how the Klacksis navigate the stars. When the {i}Be-quiet{/i} came, they hunted us down with our own music based navigation arrays."
			})
			Ren.story_state = "player02"
		
		"player02":
			Ren.say({
				"who":"Player",
				"what": "I think I'm ready"
			})
			Ren.story_state = "alien03"

		"alien03":
			Ren.say({
				"who":"alien",
				"what": "Hahaha, no, train with Jane Doe, you'll need some more VR practice (PvP) with a friend before you venture into {i}Be-quiet{/i} space."
			})
			Ren.story_state = "player03"
		
		"player03":
			Ren.say({
				"who":"Player",
				"what": " LOL, before the war, people used to do gamejams, this sounds like a lazy way to avoid a singular player campaign."
			})
			Ren.story_state = "alien04"
		
		"alien04":
			Ren.say({
				"who":"alien",
				"what": "The longer you waste, the less likely will be able to full release your ship, now go train!"
			})
			Ren.story_state = "exit_dialog"
		
		"exit_dialog":
			Globals.talking = false
			Window.hide()