extends Sprite

func _process(delta):
	var norm_mouse_pos = get_global_mouse_position().normalized()
	get_material().set_shader_param("mouse_pos", norm_mouse_pos)