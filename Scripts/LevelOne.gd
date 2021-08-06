extends Node2D

func _ready():
	pass

func distanceBetweenObjects(object1: Node2D, object2: Node2D):
	var a = Vector2( object2.position - object1.position )
	return sqrt( (a.x * a.x) + (a.y * a.y) )
