extends TextureButton



func _ready():
	modulate = Color(Globals.colors[randi() % Globals.colors.size()])

func _on_warranty_pressed():
	Globals.warranty_color = modulate


func _on_warranty_mouse_entered():
	get_material().set_shader_param("highlighted", true)

func _on_warranty_mouse_exited():
	get_material().set_shader_param("highlighted", false)
	