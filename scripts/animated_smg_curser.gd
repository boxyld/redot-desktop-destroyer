extends AnimatedSprite2D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
func _process(delta: float):
	
	global_position = get_global_mouse_position() + Vector2(60,50)
	if(Input.is_action_pressed("m1")):
		play("shoot")
	else:
		play("idle")
