extends Node

# Settings menu options
var isMusicOn = true
var isSFXOn = true

signal player_died


var playerOneObject
var cameraObject




# utility function that will clear all children of a node
# the game loop uses this to clear out a level before loading a new one
func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func player_died():
	emit_signal('player_died')
	
func distanceBetweenObjects(object1: Node2D, object2: Node2D):
	var a = Vector2( object2.position - object1.position )
	return sqrt( (a.x * a.x) + (a.y * a.y) )
