extends RigidBody

var lifetime = 5

func _process(delta):
	lifetime -= delta
	if lifetime <= 0:
		queue_free()

func _on_water_bullet_body_entered(body):
	$mesh.hide()
	sleeping = true
	$particles.emitting = true
	$Timer.start()
	
func _on_Timer_timeout():
	queue_free()
