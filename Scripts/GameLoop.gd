extends Control

var isGamePaused = false

func _ready():
	$PauseMenu/MenuOptions/ReturnToGame/Button.connect("button_down", Callable(self, "toggle_pause"))
	$PauseMenu/MenuOptions/ReturnToTitle/Button.connect("button_down", Callable(self, "load_main_menu"))
	
	# level will emit a player_dead() signal...which Global can listen to
	Global.connect("player_dead", Callable(self, 'show_gameover'))
	
	# only play music if it is enabled
	if(Global.isMusicOn):
		$Music.play()
	
	# load level one by default
	load_level("res://Scenes/LevelOne.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("ui_pause"):
		toggle_pause()

func load_main_menu():
	get_tree().paused = false # in case we paused the screen
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func toggle_pause():
	# get_tree().paused = not get_tree().paused
	isGamePaused = not isGamePaused
	$PauseMenu.visible = isGamePaused
	$Music.volume_db = -12 if isGamePaused else 0 # make bg music quiet on pause
	
	# any nodes that have their "pause mode" set to STOP will pause
	# look at the game loop scene and notice everything is set to process
	# except the InGame object. That helps all the UI and music keep working
	# when the game is paused
	get_tree().paused = isGamePaused


func load_level(levelPath):
	get_tree().paused = false # in case we paused the screen
	Global.delete_children($InGame) # clear out the demo placeholder first
	var next_level_resource = load(levelPath)
	var next_level = next_level_resource.instantiate()
	$InGame.add_child(next_level)
