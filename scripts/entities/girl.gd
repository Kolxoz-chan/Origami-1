class_name Girl extends Entity

var target = null 

func _physics_process(delta):
	var vec = Vector3.ZERO
	
	vec = gravity_controll(vec, delta)
	
	if target:
		look_at(target.translation, Vector3.UP)
		vec -= transform.basis.z * speed
	
	move_and_slide(vec, Vector3.UP)


func _on_Vision_body_entered(body):
	if body is Player:
		target = body


func _on_Vision_body_exited(body):
	if body is Player:
		target = null
