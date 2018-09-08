extends Sprite

func _process(delta):
	get_material().set_shader_param("mouse_pos", get_global_mouse_position().normalized())