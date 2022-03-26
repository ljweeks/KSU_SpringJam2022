extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if(get_overlapping_bodies()):
		for body in get_overlapping_bodies():
			if(body.name == "player"):
				get_tree().change_scene("res://win.tscn")
