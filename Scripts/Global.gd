extends Node

# Settings menu options
var isMusicOn = true
var isSFXOn = true

signal player_died

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# utility function that will clear all children of a node
# the game loop uses this to clear out a level before loading a new one
func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()


func player_died():
	emit_signal('player_died')
