class_name Player extends Entity

onready var camera = $Camera
onready var bullet = load("res://prefabs/bullets/water_bullet.tscn")

var sens = 0.3

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			var dir = camera.global_transform.basis.z
			var pos =  camera.global_translation - dir / 2
			var obj : RigidBody = bullet.instance()
			
			get_tree().current_scene.add_child(obj)
			obj.translation = pos
			obj.apply_central_impulse(-dir * 10)
		
	
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * sens
		camera.rotation_degrees.x -= event.relative.y * sens
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -75, 75)

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

func _physics_process(delta):
	var vec = Vector3.ZERO
	vec = gravity_controll(vec, delta)
	vec = motion_controll(vec, delta)
	
	
	move_and_slide(vec, Vector3(0, 1, 0))

