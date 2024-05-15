extends KinematicBody

onready var camera = $Camera

var gravity = 0
var speed = 3
var sens = 0.3

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * sens
		camera.rotation_degrees.x -= event.relative.y * sens
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -75, 75)

func jump(power):
	gravity = power

func motion_controll(vec, delta):
	if Input.is_action_pressed("ui_up"):
		vec -= transform.basis.z * speed
	
	if Input.is_action_pressed("ui_down"):
		vec += transform.basis.z * speed
	
	if Input.is_action_pressed("ui_left"):
		vec -= transform.basis.x * speed
	
	if Input.is_action_pressed("ui_right"):
		vec += transform.basis.x * speed
		
	if Input.is_action_pressed("ui_jump") and is_on_floor():
		jump(5)
		
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	return vec

func gravity_controll(vec, delta):
	gravity -= delta * 10
	if is_on_floor():
		gravity = 0
	
	vec.y += gravity
	
	return vec

func _physics_process(delta):
	var vec = Vector3.ZERO
	vec = gravity_controll(vec, delta)
	vec = motion_controll(vec, delta)
	
	
	move_and_slide(vec, Vector3(0, 1, 0))

