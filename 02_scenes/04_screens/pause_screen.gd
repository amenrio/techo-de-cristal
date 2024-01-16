extends Control

var paused:bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed('pause'):
		pauseMenu()
	
func pauseMenu():
	if paused:
		$AnimationPlayer.play("hide_pause")
		hide()
		get_tree().paused = false
	else:
		get_tree().paused = true
		show()
		$AnimationPlayer.play("show_pause")
		
	paused = !paused
	
func _on_b_menu_pressed():
	pauseMenu()
	get_tree().change_scene_to_file("res://02_scenes/04_screens/menu_screen.tscn")


func _on_b_volver_pressed():
	pauseMenu()

func _on_b_controles_pressed():
	$controlsScreen.show()
