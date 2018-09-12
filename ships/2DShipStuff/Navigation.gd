extends Navigation2D

# Member variables
const SPEED = 200.0

var begin = Vector2()
var end = Vector2()
var path = []
var keyboard_speed = 5


func _process(delta):
	if path.size() > 1:
		var to_walk = delta * SPEED
		while to_walk > 0 and path.size() >= 2:
			var pfrom = path[path.size() - 1]
			var pto = path[path.size() - 2]
			var d = pfrom.distance_to(pto)
			if d <= to_walk:
				path.remove(path.size() - 1)
				to_walk -= d
			else:
				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
				to_walk = 0
		
		var atpos = path[path.size() - 1]
		$Player.position = atpos
		
		if path.size() < 2:
			path = []
			set_process(false)
	else:
		set_process(false)


func _update_path():
	var p = get_simple_path(begin, end, true)
	path = Array(p) # PoolVector2Array too complex to use, convert to regular array
	path.invert()
	
	set_process(true)


func _input(event):
	if event.is_action_pressed("left_mouse_button"):
		begin = $Player.position
		# Mouse to local navigation coordinates
		end = get_global_mouse_position() - position
		_update_path()
	
	if event.is_action_pressed("up"):
		begin = $Player.position
		# Mouse to local navigation coordinates
		var proposed_pos = begin
		proposed_pos.y += keyboard_speed
		end = proposed_pos - position
		_update_path()
	
	if event.is_action_pressed("down"):
		begin = $Player.position
		# Mouse to local navigation coordinates
		var proposed_pos = begin
		proposed_pos.y -= keyboard_speed
		end = proposed_pos - position
		_update_path()
	
	if event.is_action_pressed("right"):
		begin = $Player.position
		# Mouse to local navigation coordinates
		var proposed_pos = begin
		proposed_pos.x += keyboard_speed
		end = proposed_pos - position
		_update_path()
	
	if event.is_action_pressed("left"):
		begin = $Player.position
		# Mouse to local navigation coordinates
		var proposed_pos = begin
		proposed_pos.x -= keyboard_speed
		end = proposed_pos - position
		_update_path()