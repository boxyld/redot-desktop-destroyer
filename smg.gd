extends Node2D


# Called when the node enters the scene tree for the first time.


func _on_timer_timeout() -> void:
	get_node("Sprite2D")
	rotate(90) # Replace with function body.
