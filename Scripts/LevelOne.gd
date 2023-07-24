extends Node3D

# example of how a conversation can work with a distance set
var narratorTextIndex = 0 # loop through messages
var narratorText = ['WAIT!!!', 
	'THERE IS MORE TO LIFE THAN DEATH',
	'JUST RELAX AND HANG OUT FOR A BIT']


func _ready():
	$UI/Conversation.connect("messageEnded", Callable(self, "_messageEnded"))
	$DeathCube.connect("body_entered", Callable(self, "_deathCubeEntered"))

func _deathCubeEntered(body):
	get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")

func _canShowMessage():
	
	# not the clearest way to do dialogue..but ok for a short demo
	# show message if player is close to death element
	# the message shown increments when the last message ends
	# which is called by the conversation script...into this one
	var onLastMessage = narratorTextIndex == narratorText.size()
	return $UI/Conversation.visible == false != onLastMessage

func _process(delta):
	
	if(_canShowMessage()):
		var closeDistance = 5 # pixels where object is close
		var dist = distanceBetweenObjects($Player, $DeathCube)
		if(dist < closeDistance):
			$UI/Conversation.showConversation(narratorText[narratorTextIndex], 2.5)

func _messageEnded():
	narratorTextIndex += 1

func distanceBetweenObjects(object1: Node3D, object2: Node3D):
	var a = Vector3( object2.position - object1.position )
	return sqrt( (a.x * a.x) + (a.y * a.y)  + (a.z * a.z) )
