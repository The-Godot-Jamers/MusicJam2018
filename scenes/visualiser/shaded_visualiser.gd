extends TextureRect


func _process(delta):
	var bus
	bus = AudioServer.get_bus_index("1")
	get_material().set_shader_param("a1", abs((AudioServer.get_bus_peak_volume_left_db(bus,0) + AudioServer.get_bus_peak_volume_right_db(bus,0)) / 2) / 20)
	#print(abs((AudioServer.get_bus_peak_volume_left_db(bus,0) + AudioServer.get_bus_peak_volume_right_db(bus,0)) / 2)/20)
	bus = AudioServer.get_bus_index("2")
	get_material().set_shader_param("a2", abs((AudioServer.get_bus_peak_volume_left_db(bus,0) + AudioServer.get_bus_peak_volume_right_db(bus,0)) / 2) / 20)
	bus = AudioServer.get_bus_index("3")
	get_material().set_shader_param("a3", abs((AudioServer.get_bus_peak_volume_left_db(bus,0) + AudioServer.get_bus_peak_volume_right_db(bus,0)) / 2) / 20)
	bus = AudioServer.get_bus_index("4")
	get_material().set_shader_param("a4", abs((AudioServer.get_bus_peak_volume_left_db(bus,0) + AudioServer.get_bus_peak_volume_right_db(bus,0)) / 2) / 20)
	bus = AudioServer.get_bus_index("5")
	get_material().set_shader_param("a5", abs((AudioServer.get_bus_peak_volume_left_db(bus,0) + AudioServer.get_bus_peak_volume_right_db(bus,0)) / 2) / 20)
	bus = AudioServer.get_bus_index("6")
	get_material().set_shader_param("a6", abs((AudioServer.get_bus_peak_volume_left_db(bus,0) + AudioServer.get_bus_peak_volume_right_db(bus,0)) / 2) / 20)