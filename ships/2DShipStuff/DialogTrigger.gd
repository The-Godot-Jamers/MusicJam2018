extends Area2D

var dialog_id = "some_dialog"
var is_in_area = false

func _ready():
	connect("body_entered", self, "_on_enter_trigger")
	connect("body_exited", self, "_on_exit_trigger")
	Ren.connect("story_step", self, "story")

func _on_enter_trigger(body):
	if body.name != "Player":
		return
	is_in_area = true

func _process(delta):
	if not is_in_area:
		return

	if Globals.talking:
		return

	if Input.is_action_just_pressed("shoot"):
		active_dialog()

func _on_exit_trigger(body):
	if body.name != "Player":
		return
	is_in_area = false

func active_dialog():
	Ren.jump(
		"shipdeck",
		dialog_id,
		"start",
		false
	)
	if not Ren.started:
		Ren.start()
	
	if Ren.current_node != self:
		Ren.current_node = self

func story(dialog_name):
	if dialog_name != dialog_id:
		return
