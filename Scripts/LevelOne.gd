extends Node2D

func _ready():
	
	# save references to common objects that a lot of nodes reference
	Global.playerOneObject = get_node('Player')
	Global.cameraObject = get_node('Camera2D')
	
	if(Global.isMusicOn):
		$Music.play()

func distanceBetweenObjects(object1: Node2D, object2: Node2D):
	var a = Vector2( object2.position - object1.position )
	return sqrt( (a.x * a.x) + (a.y * a.y) )
