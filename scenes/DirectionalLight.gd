extends DirectionalLight

func _process(delta):
	#so player has allways light
	translation.x = get_parent().get_node("mainship").translation.x
	translation.y = get_parent().get_node("mainship").translation.y
	