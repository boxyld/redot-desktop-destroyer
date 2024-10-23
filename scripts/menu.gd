extends Node2D




func _process(delta: float) -> void:
	
	# add a routing to escape the app , temporary for now 
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
