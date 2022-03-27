extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	playing = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time >= 65:
		playing = true
		time = 0
