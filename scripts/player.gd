extends CharacterBody2D

const SPEED = 400.0
const VIEWPORT_WIDTH = 1080
const VIEWPORT_HEIGHT = 1920
const RADIUS = 125

# Current player color (updated by game controller based on ability)
var current_color = Color(0.4, 0.9, 0.4, 1.0)

func _ready():
	queue_redraw()

func _physics_process(delta):
	# Get input direction for horizontal movement
	var direction_x = Input.get_axis("move_left", "move_right")
	
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Get input direction for vertical movement
	var direction_y = Input.get_axis("move_up", "move_down")
	
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	# Keep player within bounds
	position.x = clamp(position.x, RADIUS + 10, VIEWPORT_WIDTH - (RADIUS + 10))
	position.y = clamp(position.y, RADIUS + 10, VIEWPORT_HEIGHT - (RADIUS + 10))
	
	move_and_slide()

func _draw():
	# Draw player as a circle with current ability color
	draw_circle(Vector2.ZERO, RADIUS, current_color.darkened(0.3))
	draw_circle(Vector2.ZERO, RADIUS, current_color)
