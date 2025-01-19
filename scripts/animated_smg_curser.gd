extends AnimatedSprite2D

var switchable = Across.swicher

func _ready() -> void:
	if switchable == 1:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta: float):
	if switchable == 1:
			global_position = get_global_mouse_position() + Vector2(60,50)
			if(Input.is_action_pressed("m1")):
				play("shoot")
			else:
				play("idle")
