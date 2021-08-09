extends Node2D

# could link up multiple players here too if more are playing
onready var playerOneHealthLabel: Label = $PlayerOne/HealthLabel;
onready var playerOne: KinematicBody2D = get_parent().get_parent().get_node('Player')

# todo: add appropriate other stats like player image and stats

func _process(delta):
	playerOneHealthLabel.text = str(playerOne.current_health)
