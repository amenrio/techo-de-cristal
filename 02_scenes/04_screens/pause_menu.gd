extends Control
@onready var current_level = get_tree().current_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_resume_button_pressed():
	current_level.pauseMenu() # Replace with function body.


func _on_exit_button_pressed():
	get_tree().quit() # Replace with function body.

