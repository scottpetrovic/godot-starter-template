extends Sprite

onready var playerObject = get_parent().get_node("Player")
var shadowXOffset = 18
var shadowYOffset = 53; # change based on sprite. 

func _process(delta):
	# go underneath the player by default
	position = playerObject.position
	position.y += shadowYOffset
	position.x -= shadowXOffset
	
	if(playerObject.isCurrentlyJumping) :
		position.y += playerObject.jump_landing_y_pos

