extends Area2D

const RECT_SIZE = Vector2(1080, 1920)
const BG_COLOR = Color(0.0,0.0, 0.0, 1.0)

func _ready():
	z_index = 10 
	body_entered.connect(_on_body_entered)
	queue_redraw()

func _draw():
	draw_rect(Rect2(Vector2(-540,-1920), RECT_SIZE), BG_COLOR)
	draw_rect(Rect2(Vector2(-150, 0), Vector2(300,60)), Color(0.8, 0.2, 0.2, 0.7))
	

func _on_body_entered(body):
	if body.is_in_group("player"):
		# Notify game controller of collision with chaser
		get_parent().check_collision_with_chaser(self)
