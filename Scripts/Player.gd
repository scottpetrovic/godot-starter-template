extends KinematicBody2D


# Declare member variables here. Examples:
var current_health = 1 # 1 hit and you are dead
var move_speed = 100

 # adds up our directions to see which way to move
var velocity := Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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


func get_input():
	# basic 8-way movement
	velocity = Vector2()	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * move_speed
	calculate_animation_state()

func _physics_process(delta: float):
	get_input()
	velocity = move_and_slide(velocity)

func _on_DamageItem_body_entered(_body):
	current_health -= 1
	if(current_health <= 0):
		get_tree().change_scene("res://Scenes/GameOver.tscn")
		# Global.player_died()
