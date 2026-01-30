extends Node2D

func _ready():
	queue_redraw()

func _draw():
	# Draw elliptic shape (elongated vertically)
	var ellipse_width = 300
	var ellipse_height = 50
	var num_points = 32
	
	var points = PackedVector2Array()
	for i in range(num_points):
		var angle = (i / float(num_points)) * TAU
		var x = cos(angle) * ellipse_width
		var y = sin(angle) * ellipse_height
		points.append(Vector2(x, y))
	
	draw_colored_polygon(points, Color(0.086, 0.005, 0.005, 0.7))
	
	# Draw outline
	for i in range(num_points):
		var next_i = (i + 1) % num_points
		draw_line(points[i], points[next_i], Color(0.086, 0.005, 0.005, 0.7), 2.0)
