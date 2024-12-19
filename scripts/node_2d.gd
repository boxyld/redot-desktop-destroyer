extends Node2D
var link := preload("res://scenes/smg.tscn")
# Called when the node enters the scene tree for the first time.
  # Adjust the range as needed
func shoot():
	var rng = RandomNumberGenerator.new()
	var random_x_offset = rng.randf_range(-50, 50)  # Adjust the range as needed
	var random_y_offset = rng.randf_range(-50, 50)
	var yld = link.instantiate()
	var positionyld = get_global_mouse_position()+ Vector2(random_x_offset,random_y_offset)
	print(positionyld)
	yld.position = get_global_mouse_position()+ Vector2(random_x_offset,random_y_offset)
	add_child(yld)

func _on_timer_timeout() -> void:
	if Input.is_action_pressed("m1"):
		shoot()
		var smgs = get_node("AudioStreamPlayer2D")
		smgs.play()


func _process(delta: float) -> void:
	
	# add a routing to escape the app , temporary for now 
	if Input.is_action_just_pressed("ui_cancel"):
		$AnimatedSprite2D.queue_free()
		take_screenshot()
		
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
		
		


func take_screenshot():
	var view_port = get_viewport()
	
	view_port.get_texture().get_image().save_png("user://Screenshot.png")
	var os_dicrectory :String = OS.get_user_data_dir()
	print(" saved screenshot at ",os_dicrectory)

		
