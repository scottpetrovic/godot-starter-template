extends Node2D


# example of how a conversation can work with a distance set
var narratorTextIndex = 0 # loop through messages
var narratorText = ['WAIT!!!', 
	'THERE IS MORE TO LIFE THAN DEATH',
	'JUST RELAX AND HANG OUT FOR A BIT']


func _ready():
	$UI/Conversation.connect("messageEnded", Callable(self, "_messageEnded"))

func _canShowMessage():
	
	# not the clearest way to do dialogue..but ok for a short demo
	# show message if player is close to death element
	# the message shown increments when the last message ends
	# which is called by the conversation script...into this one
	var onLastMessage = narratorTextIndex == narratorText.size()
	return $UI/Conversation.visible == false != onLastMessage

func _process(delta):
	if(_canShowMessage()):
		var closeDistance = 200 # pixels where object is close
		var dist = distanceBetweenObjects($Player, $DamageItem)
		if(dist < closeDistance):
			$UI/Conversation.showConversation(narratorText[narratorTextIndex], 2.5)

func _messageEnded():
	narratorTextIndex += 1

func distanceBetweenObjects(object1: Node2D, object2: Node2D):
	var a = Vector2( object2.position - object1.position )
	return sqrt( (a.x * a.x) + (a.y * a.y) )
