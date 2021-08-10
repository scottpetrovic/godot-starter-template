extends Control

func _ready():
	# pause menu options
	$MenuOptions/GameStart/Button.connect("button_down", self, "load_game")
	$MenuOptions/Options/Button.connect("button_down", self, "load_options")
	$MenuOptions/ExitGame/Button.connect("button_down", self, "exit_game")


func load_game():
	get_tree().change_scene("res://Scenes/LevelOne.tscn")

func load_options():
	get_tree().change_scene("res://Scenes/OptionsMenu.tscn")
	
func exit_game():
	get_tree().quit()
