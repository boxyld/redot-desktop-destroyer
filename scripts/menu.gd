extends Control

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.key_label == 49:
			_on_button_smg_pressed()
			
func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_button_smg_pressed() -> void:
	Across.swicher = "SMG"
	switch()

func switch() -> void:
	visible = false
	get_parent().get_parent().bleh(Across.swicher)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
