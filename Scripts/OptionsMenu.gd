extends Control

func _ready():
	$MenuContainer/Music/Button.connect("button_down", Callable(self, "toggle_music"))
	$MenuContainer/SFX/Button.connect("button_down", Callable(self, "toggle_sfx"))
	$MenuContainer/ReturnToTitle/Button.connect("button_down", Callable(self, "load_main_menu"))


func _process(_delta): 
	# update the UI whether sound and effects are on
	$MenuContainer/Music.item_name = 'MUSIC ON' if Global.isMusicOn else 'MUSIC OFF'
	$MenuContainer/SFX.item_name = 'SFX ON' if Global.isSFXOn else 'SFX OFF'
	pass

func toggle_music():
	Global.isMusicOn = not Global.isMusicOn
	
func toggle_sfx():
	Global.isSFXOn = not Global.isSFXOn

func load_main_menu():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
