extends KinematicBody2D

signal speed_updated
signal state_changed

const MAX_WALK_SPEED = 450
const MAX_RUN_SPEED = 700

const BUMP_DISTANCE = 60
const BUMP_DURATION = 0.2
const MAX_BUMP_HEIGHT = 50


const JUMP_DURATION = 0.6
const MAX_JUMP_HEIGHT = 80

const AIR_ACCELERATION = 1000
const AIR_DECCELERATION = 2000
const AIR_STEERING_POWER = 50

const GAP_SIZE = Vector2(128, 80)


var speed = 0
var max_speed = 0


var height = 0.0 setget set_height

var max_air_speed = 0
var air_speed = 0
var air_velocity = Vector2()
var air_steering = Vector2()


var input_direction = Vector2()
var look_direction = Vector2(1, 0)
var last_move_direction = Vector2(1, 0)

var velocity = Vector2()

enum STATES { SPAWN, IDLE, MOVE, JUMP, BUMP, FALL }
var state = null


func _ready():
	_change_state(IDLE)
	$Tween.connect('tween_completed', self, '_on_Tween_tween_completed')

	$AnimationPlayer.stop()

	for gap in get_tree().get_nodes_in_group('gap'):
		gap.connect('body_fell', self, '_on_Gap_body_fell')


func _change_state(new_state):
	# Initialize the new state
	match new_state:
		SPAWN:
			$Tween.interpolate_property(self, 'scale', scale, Vector2(1,1), .4, Tween.TRANS_QUAD, Tween.EASE_IN)
			$Tween.start()
		IDLE:
			speed = 0
			$AnimationPlayer.play('idle')
		MOVE:
			speed = 200
			$AnimationPlayer.play('walk')
		JUMP:
			air_speed = speed
			max_air_speed = max_speed
			air_velocity = velocity if input_direction else Vector2()
			$AnimationPlayer.play('idle')

			$Tween.interpolate_method(self, '_animate_jump_height', 0, 1, JUMP_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
			$Tween.start()
		BUMP:
			$AnimationPlayer.stop()

			$Tween.interpolate_property(self, 'position', position, position + BUMP_DISTANCE * -last_move_direction, BUMP_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
			$Tween.interpolate_method(self, '_animate_bump_height', 0, 1, BUMP_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
			$Tween.start()
		FALL:
			print('entered fall')
			$Tween.interpolate_property(self, 'scale', scale, Vector2(0,0), .4, Tween.TRANS_QUAD, Tween.EASE_IN)
			$Tween.start()
	state = new_state
	emit_signal('state_changed', new_state)


func _physics_process(delta):
	update_direction()

	if state == IDLE and input_direction:
		_change_state(MOVE)
	elif state == MOVE:
		if not input_direction:
			_change_state(IDLE)

		var collision_info = move()
		if collision_info:
			var collider = collision_info.collider
			if max_speed == MAX_RUN_SPEED and collider.is_in_group('environment'):
				_change_state(BUMP)
	elif state == JUMP:
		jump(delta)


func update_direction():
	if not input_direction:
		return

	last_move_direction = input_direction
	if input_direction.x in [-1, 1]:
		look_direction.x = input_direction.x
		$Pivot.set_scale(Vector2(look_direction.x, 1))


func move():
	if input_direction:
		if speed != max_speed:
			speed = max_speed
	else:
		speed = 0
	emit_signal('speed_updated', speed)

	velocity = input_direction.normalized() * speed
	move_and_slide(velocity, Vector2(), 5, 2)

	var slide_count = get_slide_count()
	return get_slide_collision(slide_count - 1) if slide_count else null


func jump(delta):
	if input_direction:
		air_speed += AIR_ACCELERATION * delta
	else:
		air_speed -= AIR_DECCELERATION * delta
	air_speed = clamp(air_speed, 0, max_air_speed)
	emit_signal('speed_updated', air_speed)

	var target_velocity = air_speed * input_direction.normalized()
	var steering_velocity = (target_velocity - air_velocity).normalized() * AIR_STEERING_POWER
	air_velocity += steering_velocity

	move_and_slide(air_velocity)


func _on_Tween_tween_completed(object, key):
	if key == ":position":
		_change_state(IDLE)
	elif key == ":_animate_jump_height":
		_change_state(IDLE)
	elif key == ":scale":
		if state == FALL:
			# TODO: USE WORLD GRID/TILEMAP INSTEAD
			position -= last_move_direction * GAP_SIZE
			_change_state(SPAWN)
		elif state == SPAWN:
			_change_state(IDLE)


func _animate_bump_height(progress):
	self.height = pow(sin(progress * PI), 0.4) * MAX_BUMP_HEIGHT


func _animate_jump_height(progress):
	self.height = pow(sin(progress * PI), 0.7) * MAX_JUMP_HEIGHT


func set_height(value):
	height = value
	$Pivot.position.y = -value
	var shadow_scale = 1.0 - value / MAX_JUMP_HEIGHT * 0.5
	$Shadow.scale = Vector2(shadow_scale, shadow_scale)


func _on_Gap_body_fell(rid):
	if rid == get_rid():
		_change_state(FALL)
