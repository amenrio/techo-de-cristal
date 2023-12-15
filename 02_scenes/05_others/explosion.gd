extends GPUParticles2D

func _ready():
	$AudioStreamPlayer.play()
	
func _on_timer_timeout():
	get_tree().queue_delete(self)
