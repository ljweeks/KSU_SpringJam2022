extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

func _ready():
	connect("pressed", self, "start_game")
	OS.window_fullscreen = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
# Called every frame. 'delta' is the elapsed time since the previous frame.


		
func start_game():
	get_tree().change_scene("res://Spatial.tscn")

