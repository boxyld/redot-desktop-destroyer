extends Node2D

var bullet_impact := preload("res://scenes/bulletimpact.tscn")

# show selected weapon in the menu
func bleh(weapon : String):
	if weapon == "SMG":
		$SMG.visible = true

	
func shoot() -> void:
	if Across.swicher == "SMG":
		var yld = bullet_impact.instantiate()
		yld.rotation_degrees = randf_range(0,360)
		yld.scale.x = randf_range(0.05,0.1125)
		yld.scale.y = yld.scale.x
		yld.position = get_global_mouse_position() + Vector2(randf_range(-50, 50),randf_range(-50, 50))
		add_child(yld)
	
func _process(delta: float) -> void:
	$AudioListener2D.position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	if Input.is_action_just_pressed("ui_cancel") and visible:
		Across.swicher = "blank"
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$CanvasLayer/Menu.visible = true
		# hide all the weapons in the scene
		$SMG.visible = false
