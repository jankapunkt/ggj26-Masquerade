extends CanvasLayer
## UI Controller for Tetris Game
##
## Manages the display of game information including:
## - Current score
## - Game over messages
## - Control instructions
##
## References:
## - CanvasLayer: https://docs.godotengine.org/en/stable/classes/class_canvaslayer.html
## - Label: https://docs.godotengine.org/en/stable/classes/class_label.html

@onready var score_label = $ScoreLabel
@onready var game_over_label = $GameOverLabel
@onready var instructions_label = $InstructionsLabel

## Called when the node enters the scene tree.
## Initializes UI elements and hides game over message.
func _ready():
	if game_over_label:
		game_over_label.visible = false

## Updates the score display with the current score value.
## @param new_score: The current game score to display
func update_score(new_score: int):
	if score_label:
		score_label.text = "Score: " + str(new_score)

## Shows the game over message and instructions to restart.
func show_game_over():
	if game_over_label:
		game_over_label.visible = true

## Hides the game over message when starting a new game.
func hide_game_over():
	if game_over_label:
		game_over_label.visible = false
