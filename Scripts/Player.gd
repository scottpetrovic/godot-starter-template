extends CharacterBody2D


# Declare member variables here. Examples:
var current_health = 1 # 1 hit and you are dead
var move_speed = 100

 # adds up our directions to see which way to move
# var velocity := Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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

func _physics_process(delta: float):
	get_input()
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity

func _on_DamageItem_body_entered(_body):
	current_health -= 1
	if(current_health <= 0):
		get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
