extends GPUParticles2D

#func _ready():
#	emitting = true

func _on_timeout_timeout():
	queue_free()
