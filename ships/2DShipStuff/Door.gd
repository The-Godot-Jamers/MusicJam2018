extends Node2D

var can_be_opened = true ## used to open/close door
var is_in_area = false

func _ready():
	$Area2D.connect("body_entered", self, "_on_enter_door_area")
	$Area2D.connect("body_exited", self, "_on_exit_door_area")

func _on_enter_door_area(body):
	if body.name != "Player":
		return
	is_in_area = true

func _process(delta):
	if not is_in_area:
		return
	
	if can_be_opened:
		$AnimationPlayer.play("open")
		can_be_opened = false

func _on_exit_door_area(body):
	if body.name != "Player":
		return

	is_in_area = false

	if not can_be_opened:
		$AnimationPlayer.play_backwards("open")
		can_be_opened = true


