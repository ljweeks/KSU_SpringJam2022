extends KinematicBody


# Declare member variables here. Examples:
export var speed = 3.7
onready var particle = $Pivot/Camera/dangerEffect
onready var camera = $Pivot/Camera
onready var jump_sound = get_node("jump")
var mouse_sensitivity = 0.002
var start = Vector3(0, 16, 0)
export var fall_accel = -70
var doubleJump = false
var velocity = Vector3.ZERO
var offEdgeTime = 0.0
var coyeteTime = 0.3
var jump = false
var max_speed = 300
var jump_power = 25
var paused = false
var jumpTime = 0
var shake = false
var shake_power = 0
var prev_pos = global_transform.origin

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.

func get_inputs():
	var input_dir = Vector3()
	#if Input.is_action_just_pressed("reset"):
	#	global_transform.origin = prev_pos
	if Input.is_action_pressed("move_right"):
		input_dir += global_transform.basis.x
	if Input.is_action_pressed("move_left"):
		input_dir += -global_transform.basis.x
	if Input.is_action_pressed("move_backward"):
		input_dir += global_transform.basis.z
	if Input.is_action_pressed("move_forward"):
		input_dir += -global_transform.basis.z
	if Input.is_action_just_pressed("jump"):
		jump = true
	if Input.is_action_just_pressed("pause"):
		if(paused == false):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			paused = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			paused = false
	input_dir = input_dir.normalized()
	return input_dir

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2)

func _physics_process(delta):
	velocity.y += fall_accel * delta
	var vel = get_inputs() * speed + (0.93 * velocity)
	if(is_on_floor()):
		vel = vel * 0.98
		doubleJump = false
		offEdgeTime = 0
	else:
		offEdgeTime += delta
	if vel.x > max_speed:
		vel.x = max_speed
	if vel.x < -max_speed:
		vel.x = -max_speed
	if vel.z > max_speed:
		vel.z = max_speed
	if vel.z < -max_speed:
		vel.z = -max_speed
	
	velocity.x = vel.x
	velocity.z = vel.z
	
	if(jump == true and (not is_on_floor()) and offEdgeTime > coyeteTime and doubleJump == false):
		velocity.y = jump_power * 0.8 #double jump power
		#velocity.x = velocity.x * 1.05
		#velocity.z = velocity.z * 1.05
		doubleJump = true
		jump_sound.play()
	
	if(jump == true and (is_on_floor() or offEdgeTime < coyeteTime)):
		velocity.y = jump_power
		velocity.x = velocity.x * 1.05
		velocity.z = velocity.z * 1.05
		jump_sound.play()
		
	if(jump == true):
		jumpTime += delta
	
	jump = false
	
	if(global_transform.origin.y < -100):
		velocity = velocity * 0
		global_transform.origin = prev_pos
		doubleJump = false
	
	if shake_power > 0:
		shake()
		shake_power -= 1
	
	
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
	if is_on_floor() and jumpTime > 0.005:		
		offEdgeTime = 0
		shake_power = jumpTime * 100
		jumpTime = 0
		prev_pos = global_transform.origin
		prev_pos.y += 5

func shake():
	camera.set_h_offset(rand_range(-1, 1)*0.1 * shake_power)
	camera.set_v_offset(rand_range(-1, 1)*0.1 * shake_power)
	print("shake")

func _on_dangerzone_area_entered(area):
	pass # Replace with function body.


func _on_dangerzone_body_entered(body):
	if(body.name == "player"):
		print("in danger zone")
		particle.emitting = true



func _on_dangerzone_body_exited(body):
	if(body.name == "player"):
		particle.emitting = false
