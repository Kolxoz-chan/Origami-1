class_name Entity extends KinematicBody

var gravity = 0

export var speed = 3.0

func jump(power):
	gravity = power
	
func gravity_controll(vec, delta):
	gravity -= delta * 10
	if is_on_floor():
		gravity = 0
	
	vec.y += gravity
	
	return vec
