extends Camera2D

# onready delays initializing the variable until the 
# scene is loaded. A null error will happen if it is not there
onready var playerNode = get_parent().get_node("Player");

# start and end of the level
var cameraMinX = 0.0 # this will be increased as we go right (forward)
var cameraMaxX = 1500.0


func _ready():
	# camera cannot go any more left than when it starts the leve
	cameraMinX = playerNode.position.x - (get_viewport().size.x/2)

func _process(delta):	
	# if player is greater than 50% of the way to the end of the viwport...
	# we need to start moving the camera forward
	# a value of 0 means we are right at 80%. -10 means we are 10 pixels to the left
	var viewportMovePosition = self.position.x + (get_viewport().size.x*0.50)
	var distanceToMoveCamera = playerNode.position.x - viewportMovePosition

	# move the camera if we are at the right side of the viewport and need to scroll
	if (distanceToMoveCamera >= 0):
		position.x = position.x +  distanceToMoveCamera
