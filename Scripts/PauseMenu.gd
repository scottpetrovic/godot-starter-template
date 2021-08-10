extends Node2D

var isGamePaused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuOptions/ReturnToGame/Button.connect("button_down", self, "toggle_pause")
	$MenuOptions/ReturnToTitle/Button.connect("button_down", self, "load_main_menu")
	
	# level will emit a player_died() signal...which Global can listen to
	Global.connect("player_died", self, 'show_gameover')


func _process(_delta):
	if Input.is_action_just_pressed("ui_pause"):
		toggle_pause()

func load_main_menu():
	get_tree().paused = false # in case we paused the screen
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func toggle_pause():

	# get_tree().paused = not get_tree().paused
	isGamePaused = not isGamePaused
	visible = isGamePaused
	get_parent().get_parent().get_parent().get_node("Music").volume_db = -12 if isGamePaused else 0 # make bg music quiet on pause
	
	# any nodes that have their "pause mode" set to STOP will pause
	# look at the game loop scene and notice everything is set to process
	# except the InGame object. That helps all the UI and music keep working
	# when the game is paused
	get_tree().paused = isGamePaused
