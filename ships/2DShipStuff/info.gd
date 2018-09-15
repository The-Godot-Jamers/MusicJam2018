extends RichTextLabel


func _process(delta):
	visible = !Globals.talking
