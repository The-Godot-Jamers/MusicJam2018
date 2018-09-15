extends Navigation2D


export var speed = 800.0
export var keyboard_speed = 800.0
export var rot_speed = 0.5

var begin = Vector2()
var end = Vector2()
var path = []

var process_path = true

func _process(delta):
	
	handle_input(delta)

	if not process_path:
		return
		$Player/AnimatedSprite.play("idle")
	
	if path.size() > 1:
		$Player/AnimatedSprite.play("Walk_Down")
		var to_walk = delta * speed
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
			$Player.look_at(pto)
		var atpos = path[path.size() - 1]
		var new_pos = atpos - $Player.position
		$Player.move_and_collide(new_pos)

		if path.size() < 2:
			path = []
			process_path = false
			$Player/AnimatedSprite.play("idle")
	else:
		$Player/AnimatedSprite.play("idle")
		process_path = false

func _update_path():
	var p = get_simple_path(begin, end, true)
	path = Array(p) # PoolVector2Array too complex to use, convert to regular array
	path.invert()
	
	process_path = true

func nav_to(new_pos):
	begin = $Player.position
	end = new_pos - position
	_update_path()


func handle_input(delta):

	if Globals.talking:
		return

	var new_pos = $Player.position
	var mouse_pos = get_global_mouse_position()

	if Input.is_action_pressed("left_mouse_button"):
		nav_to(mouse_pos)
		return

#
#	if Input.is_action_pressed("up"):
#		new_pos.y -= keyboard_speed * delta
#		$Player.rotation_degrees = 180
#		nav_to(new_pos)
#		return
#
#	if Input.is_action_pressed("down"):
#		new_pos.y += keyboard_speed * delta
#		$Player.rotation_degrees = 0
#		nav_to(new_pos)
#		return
#
#	if Input.is_action_pressed("right"):
#		new_pos.x += keyboard_speed * delta
#		$Player.rotation_degrees = 270
#		nav_to(new_pos)
#		return
#
#	if Input.is_action_pressed("left"):
#		new_pos.x -= keyboard_speed * delta
#		$Player.rotation_degrees = 90
#		nav_to(new_pos)
#		return