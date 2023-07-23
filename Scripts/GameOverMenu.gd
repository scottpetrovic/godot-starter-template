extends Control

func _ready():
	$MenuContainer/ReturnToTitle/Button.connect("button_down", Callable(self, "load_main_menu"))

func load_main_menu():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
