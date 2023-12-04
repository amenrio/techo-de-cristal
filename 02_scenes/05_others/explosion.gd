extends GPUParticles2D

func _on_timer_timeout():
	get_tree().queue_delete(self)
