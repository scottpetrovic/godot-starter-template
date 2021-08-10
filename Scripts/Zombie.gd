extends KinematicBody2D

onready var playerObject = get_parent().get_parent().get_node('Player')

export var moveSpeed = 25
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = true
	

func _process(delta):
	calculate_animation_state()
	
func calculate_animation_state():
	# what direction we are facing (left/right)
	# velocity == 0...we aren't pressing anything, so don't calculate
	if(velocity.x > 0): $AnimatedSprite.flip_h = false
	elif(velocity.x < 0): $AnimatedSprite.flip_h = true

func _physics_process(delta):
	
	# logic for basic moving towards player
	velocity = Vector2.ZERO		
	if (playerObject):
		velocity = position.direction_to(playerObject.position) * moveSpeed
	velocity = move_and_slide(velocity)

