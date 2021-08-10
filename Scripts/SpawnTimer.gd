extends Node2D

# list of enemies to spawn
export(PackedScene) var zombie = preload('res://Scenes/Zombie.tscn')

onready var playerObject = get_parent().get_node('Player')
onready var cameraObject = get_parent().get_node('Camera2D')

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnTimer.wait_time = 3
	$SpawnTimer.connect("timeout", self, 'spawnEnemy' )

func spawnEnemy():
	
	# only have zombies for now
	var zombieInst = zombie.instance()
	
	# same y position as player for now
	zombieInst.position.y = playerObject.position.y 
	
	#zombies need to spawn just off screen
	var leftSideSpawn = cameraObject.position.x
	var rightSideSpawn = cameraObject.position.x + get_viewport().size.x
	
	# randomize what side zombines spawn from
	randomize() # updates "seed" of random number to make next operation more random
	var randomNumber = randf() # between 0.0 and 1.0
	print(randomNumber)
	zombieInst.position.x = rightSideSpawn if randomNumber > 0.5 else leftSideSpawn
	add_child(zombieInst)
