extends Area2D

signal bullet_hit_enemy(enemy)

const BULLET_RADIUS = 10.0
const VIEWPORT_HEIGHT = 1920

# Add velocity for direction
var velocity: Vector2 = Vector2.DOWN * 600  # default downwards

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))

func _process(delta):
	# Move bullet along velocity
	position += velocity * delta
	
	# Remove bullet if it goes off screen (basic bounds check)
	if position.y > VIEWPORT_HEIGHT + 100 or position.y < -100 or position.x < -100 or position.x > 1080 + 100:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		emit_signal("bullet_hit_enemy", area)
		queue_free()

func _draw():
	draw_circle(Vector2.ZERO, BULLET_RADIUS, Color.WHITE)
