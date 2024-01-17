extends GPUParticles2D
@onready var feedback_timer = $feedbackTimer
@onready var explosion_sprite = $explosionSprite

func _ready():
	$AudioStreamPlayer.play()
	
func _on_timer_timeout():
	get_tree().queue_delete(self)


func _on_feedback_timer_timeout():
	explosion_sprite.visible = false
