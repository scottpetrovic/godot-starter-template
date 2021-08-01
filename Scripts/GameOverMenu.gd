extends Control

func _ready():
	$MenuContainer/ReturnToTitle/Button.connect("button_down", self, "load_main_menu")

func load_main_menu():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
