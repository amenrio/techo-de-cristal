extends Control
var paused:bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('pause'):
		pauseMenu()
	
func pauseMenu():
	if paused:
		hide()
		get_tree().paused = false
	else:
		get_tree().paused = true	
		show()
		
	paused = !paused

func _on_resume_button_pressed():
	pauseMenu()


func _on_exit_button_pressed():
	get_tree().quit() # Replace with function body.

