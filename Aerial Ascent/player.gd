extends CharacterBody2D

var fast_fall_enabled = false
@export var speed = 400
@export var jump_speed = -800
@export var gravity = 1800
@export var fast_fall_speed = 50000
@export var scale_speed = 20
@export_range(0.0, 1.0) var friction = 10
@export_range(0.0, 1.0) var acceleration = 10
@onready var particles = $Particles
@onready var camera = $Camera2D
var max_jumps = 2  # Number of jumps allowed
var jump_scale = false

func _physics_process(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("move_left", "move_right")
	
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration * delta)
		scale = lerp(scale, Vector2(0.9, 0.7), scale_speed * delta)
		if dir > 0:
			camera.offset.x = lerp(camera.offset.x, 125.0, 2.5 * delta)
		elif dir < 0:
			camera.offset.x = lerp(camera.offset.x, -125.0, 2.5 * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
		scale = lerp(scale, Vector2(0.8, 0.8), scale_speed * delta)
		camera.offset.x = lerp(camera.offset.x, 0.0, 3 * delta)
	
	if is_on_floor():
		max_jumps = 2  # Reset jumps when touching the ground
		jump_scale = false

	if Input.is_action_just_pressed("jump") and max_jumps > 0:
		velocity.y = jump_speed
		jump_scale = true
		max_jumps -= 1
		
	if jump_scale:
		scale = lerp(scale, Vector2(0.6, 1.0), scale_speed * delta)
		
	#	# Check for fast fall button input
	if Input.is_action_just_pressed("fast_fall") and not is_on_floor():
		fast_fall_enabled = true
	else:
		fast_fall_enabled = false

	if fast_fall_enabled:
		# Apply faster fall speed if the fast fall button is pressed
		velocity.y += fast_fall_speed * delta
		scale = lerp(scale, Vector2(0.5, 1.2), 50 * delta)
		
	if velocity.x or velocity.y != 0:
		particles.emitting = true
	else:
		particles.emitting = false
	
#	print(camera.offset.x)
	
	move_and_slide()



#extends CharacterBody2D
#
#var MOVE_SPEED = 300
#var GRAVITY = 1600
#var JUMP_FORCE = -550
#var MAX_FALL_SPEED = 1600
#var MAX_JUMPS = 3 # Set the maximum number of jumps
#
#var motion = Vector2()
#var jumps = 0  # Variable to keep track of the number of jumps
#var fast_fall_enabled = false  # Variable to track if fast fall is enabled
#var FAST_FALL_SPEED = 48000  # Adjust the fast fall speed as needed
#
#func _physics_process(delta):
#	# Player movement
#	motion.x = 0
#	if Input.is_action_pressed("move_right"):
#		motion.x += MOVE_SPEED
#	if Input.is_action_pressed("move_left"):
#		motion.x -= MOVE_SPEED
#
#	# Detect if the player is on the ground
#	var is_on_ground = is_on_floor()
#
#	# Detect if the player is colliding with the ceiling
#	var is_on_ceiling = is_on_ceiling()
#
#	# Apply gravity only when not on the ground and not colliding with the ceiling
#	if not is_on_ground:
#		motion.y += GRAVITY * delta
#
#	# Jumping logic
#	if is_on_ground:
#		jumps = 0  # Reset jump count if on the ground
#		motion.y = 0  # Reset vertical motion if on the ground
#		if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("ui_accept"):
#			motion.y = JUMP_FORCE
#			jumps = 1
#	elif jumps < MAX_JUMPS:
#		if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("ui_accept"):
#			motion.y = JUMP_FORCE
#			jumps += 1
#
#	# Check for fast fall button input
#	if Input.is_action_just_pressed("fast_fall"):
#		fast_fall_enabled = true
#	else:
#		fast_fall_enabled = false
#
#	if fast_fall_enabled:
#		# Apply faster fall speed if the fast fall button is pressed
#		motion.y += FAST_FALL_SPEED * delta
#	else:
#		motion.y = clamp(motion.y, -MAX_FALL_SPEED, MAX_FALL_SPEED)
#
#	set_velocity(motion)
#	set_up_direction(Vector2(0, -1))
#	move_and_slide()
#
#	print(jumps)

