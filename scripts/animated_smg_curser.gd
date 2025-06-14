extends Node2D

const casing = preload("res://scenes/casing.tscn")
var shootable : bool = true

func _process(delta: float):
	if Across.swicher == "SMG":
		global_position = get_global_mouse_position()
		if(Input.is_action_pressed("m1")):
			if shootable:
				$AudioStreamPlayer2D.play()
				$Timer.start()
				shootable = false
				for i in range(randi_range(1,3)):
					get_parent().shoot()
				var casingy = casing.instantiate()
				casingy.position = position + Vector2(randf_range(100,128),randf_range(36,64))
				get_parent().add_child(casingy)
			$AnimationPlayer.play("shoot")
			$Sprite2D/MuzzleFlash.visible = true
			$Sprite2D/Light.scale.x = randf_range(0.25,1.0)
			$Sprite2D/Light.scale.y = $Sprite2D/Light.scale.x
			$Sprite2D/Light.self_modulate.a = randf_range(0.25,0.9)
			$Sprite2D/Light.visible = true
		else:
			$AnimationPlayer.play("idle")
			$Sprite2D/MuzzleFlash.visible = false
			$Sprite2D/Light.visible = false

func _on_timer_timeout() -> void:
	shootable = true
