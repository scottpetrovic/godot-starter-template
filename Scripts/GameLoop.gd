extends Control

var isGamePaused = false

func _ready():
	$PauseMenu/MenuOptions/ReturnToGame/Button.connect("button_down", self, "toggle_pause")
	$PauseMenu/MenuOptions/ReturnToTitle/Button.connect("button_down", self, "load_main_menu")
	
	# level will emit a player_died() signal...which Global can listen to
	Global.connect("player_died", self, 'show_gameover')
	
	# only play music if it is enabled
	if(Global.isMusicOn):
		$Music.play()
	
	# load level one by default
	load_level("res://Scenes/LevelOne.tscn")

func show_gameover():
	print('in game loop about to show game over screen')
	pass

func _process(_delta):
	if Input.is_action_just_pressed("ui_pause"):
		toggle_pause()

func load_main_menu():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func toggle_pause():
	# get_tree().paused = not get_tree().paused
	isGamePaused = not isGamePaused
	$PauseMenu.visible = isGamePaused
	$Music.volume_db = -12 if isGamePaused else 0 # make bg music quiet on pause
	
	
func load_level(levelPath):
	Global.delete_children($InGame) # clear out the demo placeholder first
	var next_level_resource = load(levelPath)
	var next_level = next_level_resource.instance()
	$InGame.add_child(next_level)
