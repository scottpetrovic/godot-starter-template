extends Area2D

export var moveSpeed = 25
export var health = 3

var velocity = Vector2.ZERO

var deathTimer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = true

func _process(delta):
	
	# dead...stop doing other stuff
	if(health <= 0):
		return
	
	calculate_animation_state()

	# logic for basic moving towards player
	velocity = Vector2.ZERO		
	if (Global.playerOneObject):
		velocity = position.direction_to(Global.playerOneObject.position) * moveSpeed * delta
	
	position += velocity


func calculate_animation_state():
	# what direction we are facing (left/right)
	# velocity == 0...we aren't pressing anything, so don't calculate
	if(velocity.x > 0): $AnimatedSprite.flip_h = false
	elif(velocity.x < 0): $AnimatedSprite.flip_h = true



func _on_Zombie_area_entered(area: Area2D):
	if (area.is_in_group("PlayerAttack")):
		health -= 1

	# death
	if(health <= 0):
		print('creating timer to kill zombie object')
		deathTimer = Timer.new()
		deathTimer.wait_time = 3.0
		deathTimer.one_shot = true
		add_child(deathTimer) # need to add it to scene for it to work
		deathTimer.connect("timeout", self, "deleteZombie")
		deathTimer.start()
		
		$CollisionShape2D.disabled = true # no more collisions
		$AnimatedSprite.set_animation('dead')

	
func deleteZombie():
	print('deleting zombie object')
	queue_free() # delete object
