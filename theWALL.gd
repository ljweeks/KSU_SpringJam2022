extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	translate(Vector3(1, 0, 0) * delta * 20) 
	if(get_overlapping_bodies()):
		for body in get_overlapping_bodies():
			if(body.name == "player"):
				print("DEAD")
