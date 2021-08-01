extends Control

var isGamePaused = false

func _ready():
	$PauseMenu/MenuOptions/ReturnToGame/Button.connect("button_down", self, "toggle_pause")
	$PauseMenu/MenuOptions/ReturnToTitle/Button.connect("button_down", self, "load_main_menu")
	
	# only play music if it is enabled
	if(Global.isMusicOn):
		$Music.play()

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
