extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var playerObject = get_parent().get_node("Player")
var shadowXOffset = 12
var shadowYOffset = 23; # change based on sprite. 

func _process(delta):
	# go underneath the player by default
	position = playerObject.position
	position.y += shadowYOffset
	position.x -= shadowXOffset
	
	if(playerObject.isCurrentlyJumping) :
		position.y = playerObject.jump_y_pos + shadowYOffset
		

	
	# if we are jumping..we need to remember where the bottom of the jump is
