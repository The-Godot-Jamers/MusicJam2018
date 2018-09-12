extends Node2D


export(bool) var closed = false ## player can't go in if true
export(String, MULTILINE) var why_closed = "" ## what player say about doors if they are closed
var can_be_open = true ## used to open/close door
var is_in_area = false

func _ready():
	$Area2D.connect("body_entered", self, "_on_enter_door_area")
	$Area2D.connect("body_exited", self, "_on_exit_door_area")
	Ren.connect("story_step", self, "story")

func _on_enter_door_area(body):
	is_in_area = true

func _process(delta):
	if not is_in_area:
		return
	
	if not Input.is_action_just_pressed("ui_accept"):
		return

	if closed:
		active_dialog()
		return
	
	if can_be_open:
		$AnimationPlayer.play("open")
		can_be_open = false

func _on_exit_door_area(body):
	is_in_area = false
	if closed:
		return
	
	if not can_be_open:
		$AnimationPlayer.play_backwards("open")
		can_be_open = true

func active_dialog():
	Ren.jump(
		"shipdeck",
		name,
		"locked",
		false
	)
	if not Ren.started:
		Ren.start()
	
	if Ren.current_node != self:
		Ren.current_node = self
	
	Window.show()

func story(dialog_name):
	if dialog_name != name:
		return

	match Ren.story_state:
		"locked":
			Ren.say({
				"who":"player",
				"what": why_closed
			})
			Ren.story_state = "exit_dialog"
		
		"exit_dialog":
			Window.hide()

