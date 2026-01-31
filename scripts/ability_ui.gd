extends Node2D

# Configuration
const CIRCLE_RADIUS = 40.0
const CIRCLE_SPACING = 120.0
const Y_POSITION = 1820.0  # Near bottom of viewport (1920 - 100)
const VIEWPORT_WIDTH = 1080

# References to game controller
var game_controller = null

func _ready():
	# Get reference to game controller
	game_controller = get_parent()

func _draw():
	if game_controller == null:
		return
	
	# Calculate center position for all 5 abilities
	var total_width = 4 * CIRCLE_SPACING  # 4 gaps between 5 circles
	var start_x = (VIEWPORT_WIDTH - total_width) / 2
	
	# Get current ability and current enemy
	var current_ability = game_controller.current_ability
	var current_enemy = game_controller.current_enemy
	var current_enemy_type = 0
	if current_enemy != null and current_enemy.has_method("get"):
		current_enemy_type = current_enemy.enemy_type
	
	# Draw each ability circle
	for i in range(1, 6):
		var x_pos = start_x + (i - 1) * CIRCLE_SPACING
		var circle_pos = Vector2(x_pos, Y_POSITION)
		
		# Get ability color
		var ability_color = game_controller.ability_config[i]["color"]
		
		# Determine if this ability is selected or wins against current enemy
		var is_selected = (i == current_ability)
		var wins_against_enemy = false
		
		if current_enemy_type > 0:
			wins_against_enemy = current_enemy_type in game_controller.ability_config[i]["wins_against"]
		
		# Draw the circle
		if is_selected:
			# Selected ability: draw larger with bright outline
			draw_circle(circle_pos, CIRCLE_RADIUS + 8, Color.WHITE)
			draw_circle(circle_pos, CIRCLE_RADIUS + 4, ability_color.lightened(0.3))
			draw_circle(circle_pos, CIRCLE_RADIUS, ability_color)
		elif wins_against_enemy:
			# Winning ability: draw with pulsing glow effect
			var pulse_scale = 1.0 + sin(Time.get_ticks_msec() * 0.005) * 0.2
			draw_circle(circle_pos, CIRCLE_RADIUS * pulse_scale, ability_color.lightened(0.5))
			draw_circle(circle_pos, CIRCLE_RADIUS, ability_color)
			# Add extra bright outline to make it clear
			draw_arc(circle_pos, CIRCLE_RADIUS + 6, 0, TAU, 32, Color.WHITE, 3.0)
		else:
			# Normal ability: draw with dimmed colors
			draw_circle(circle_pos, CIRCLE_RADIUS, ability_color.darkened(0.4))
			draw_circle(circle_pos, CIRCLE_RADIUS - 2, ability_color.darkened(0.6))
		
		# Draw ability number
		var font_color = Color.WHITE if (is_selected or wins_against_enemy) else Color(0.6, 0.6, 0.6)
		# Note: Drawing text requires a font, which we'll skip for simplicity
		# The color coding should be sufficient for gameplay

func _process(_delta):
	# Continuously redraw to show animations
	queue_redraw()
