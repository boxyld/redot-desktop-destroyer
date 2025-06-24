extends Sprite2D

var speed_mult = 1.0
var vel = Vector2(0,0)

func _ready() -> void:
	speed_mult = randf_range(0.5,1.5)
	vel = Vector2(randf_range(4,16),randf_range(-10,-4))
	rotation_degrees = randf_range(0,360)

func _process(delta: float) -> void:
	rotation_degrees += delta  * 360 * speed_mult
	vel.y += delta * 32
	position += vel
