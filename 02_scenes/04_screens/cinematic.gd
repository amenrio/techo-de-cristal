extends VideoStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_finished():
	get_tree().change_scene_to_file("res://02_scenes/04_screens/controls_pregame_screen.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://02_scenes/04_screens/controls_pregame_screen.tscn")
