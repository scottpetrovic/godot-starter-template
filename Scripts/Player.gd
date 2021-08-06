extends KinematicBody2D


# export health so UI can use it
export var current_health = 3 # 3 hits and you are dead
var move_speed = 100
var isInvincible = false # you are for a small amount of time when you get hurt
onready var rng = RandomNumberGenerator.new()
var invincibleTime = 2.0

# jumping variables
export var isCurrentlyJumping = false
var jump_max_velocity = 150 # tweak until it feels right (jump power)
var jump_gravity = 250 # tweak until it feels right (downward force)
var jump_current_velocity = 0
export var jump_y_pos = 0 # where we started jumping at to know when we land

# adds up our directions to see which way to move
var velocity := Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	$InvincibleTimer.wait_time = invincibleTime # X second delay between being hurt
	$InvincibleTimer.one_shot = true
	$InvincibleTimer.connect("timeout", self, "make_mortal")
	pass # Replace with function body.

func make_mortal():
	isInvincible = false
	var randomColor = Color(1.0, 1.0, 1.0)
	$AnimatedSprite.set_modulate(randomColor)

func _process(delta):
	if(isInvincible):
		var randomColor = Color(rng.randfn(), rng.randfn(), rng.randfn())
		$AnimatedSprite.set_modulate(randomColor)


func calculate_animation_state():

	# what direction we are facing (left/right)
	# velocity == 0...we aren't pressing anything, so don't calculate
	if(velocity.x > 0): $AnimatedSprite.flip_h = false
	elif(velocity.x < 0): $AnimatedSprite.flip_h = true

	# what sprite animation set we should play
	if(velocity.x == 0 && velocity.y == 0):
		$AnimatedSprite.set_animation('idle') 
	else:
		$AnimatedSprite.set_animation('walk') 

func get_movement():
	# basic 8-way movement
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):		
		if(blockLeftInput() == false):
			velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		if(blockDownInput() == false):
			velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		if(blockUpInput() == false):
			velocity.y -= 1
	velocity = velocity.normalized() * move_speed

func get_jumping(delta):
		
	if(isCurrentlyJumping):
		# we are already jumping...so apply pseudo-gravity
		jump_current_velocity -=  jump_gravity * delta
		
		# we landed back to our original position...so stop jumping logic
		print(jump_current_velocity)
		if(jump_y_pos < position.y):
			isCurrentlyJumping = false
		else:
			velocity.y -= jump_current_velocity
	else:
		# we are not jumping...but we might be jumping this time
		if Input.is_action_pressed("player_jump"):
			isCurrentlyJumping = true
			jump_y_pos = position.y
			jump_current_velocity = jump_max_velocity # add jump force to begin

func blockLeftInput():
	# we don't want to move left we hit the left side of the camera area
	# camera position will start out at 0
	var cameraPosition = get_parent().get_node("Camera2D").position.x
	var distanceFromLeftCameraSideToPlayer = position.x - cameraPosition
	
	var distanceToBlock = 50 # distance from camera to start blocking
	if(distanceToBlock > distanceFromLeftCameraSideToPlayer): return true
	else: return false

func blockDownInput():
	# this is a horizontal scroller, so camera is not moving up/down
	# this makes sure our character can only move down as far as the camera is
	#print(position.y)
	if(position.y > 540 || isCurrentlyJumping == true): return true
	return false

func blockUpInput():
	if(position.y < 485 || isCurrentlyJumping == true): return true
	return false

func _physics_process(delta: float):
	velocity = Vector2() # calculate new movement amount
	get_movement()
	get_jumping(delta)
	calculate_animation_state()
	velocity = move_and_slide(velocity)

# external objects call this and send in how much damage is done
func player_damaged(body, damageDone: int):
	if(isInvincible == false):
		current_health -= damageDone
	
	if(current_health <= 0):
		get_tree().change_scene("res://Scenes/GameOver.tscn")
		# Global.player_died()
	else:
		# invincible for a bit so you don't get hurt
		isInvincible = true
		$InvincibleTimer.start()
