extends Node2D

const file_path_pers :String = "user://Screenshot.png"
var background_persistence

func _ready() -> void:
	
	if FileAccess.file_exists(file_path_pers):
		
		var image_file :Image
		image_file = Image.load_from_file(file_path_pers)
		print("I found the file ")
		if image_file:
			$screenshot.texture = ImageTexture.create_from_image(image_file)
		
	var screen :Vector2i = get_viewport().size
	var center :Vector2 = Vector2(screen.x/2, screen.y/2)
	$sprite_menu.position = center
	$Sprite2D.position = $sprite_menu/Marker2D.global_position
	$screenshot.position = center
	
	print("scale factor ", get_tree().root.content_scale_factor)
func _process(delta: float) -> void:
	
	# add a routing to escape the app , temporary for now 
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


	if Input.is_action_just_pressed("ui_left"):

		$sprite_menu.frame -= 1

	if Input.is_action_just_pressed("ui_right"):
		$sprite_menu.frame += 1
	if Input.is_action_just_pressed("ui_up") and $sprite_menu.frame == 3:
		$sprite_menu.frame = 0
	if Input.is_action_just_pressed("ui_up") and $sprite_menu.frame == 4:
		$sprite_menu.frame = 1
	if Input.is_action_just_pressed("ui_up") and $sprite_menu.frame == 5:
		$sprite_menu.frame = 2
		
	if Input.is_action_just_pressed("ui_down") and $sprite_menu.frame == 0:
		$sprite_menu.frame = 3
	if Input.is_action_just_pressed("ui_down") and $sprite_menu.frame == 1:
		$sprite_menu.frame = 4
	if Input.is_action_just_pressed("ui_down") and $sprite_menu.frame == 2:
		$sprite_menu.frame = 5
		
		
	if Input.is_action_just_pressed("ui_select") and $sprite_menu.frame == 0:

		get_tree().change_scene_to_file("res://scenes/smg_tool.tscn")
