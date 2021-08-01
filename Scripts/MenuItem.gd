# tool allows the editor to see override values 
# in editor set on exported variables
tool 

extends HBoxContainer
class_name MenuItem

# options that the parent can override
export var item_name: String = "ITEM" setget _set_item_name
export var item_font_color: Color = Color.black setget _set_item_font_color

func _ready():
	$Button.connect("mouse_entered", self, "_add_text_highlight")
	$Button.connect("mouse_exited", self, "_remove_text_highlight")
	
	# sound effect when hovering over item
	$SFX.stream = preload('res://Sounds/menu_hover.wav')

func _remove_text_highlight():
	$SelectedBefore.visible = false
	$SelectedAfter.visible = false
	
func _add_text_highlight():
	$SelectedBefore.visible = true
	$SelectedAfter.visible = true
	
	if(Global.isSFXOn):
		$SFX.play()

func _set_item_name(name: String):
	item_name = name
	$Button.text = item_name
	
func _set_item_font_color(value: Color):
	item_font_color = value
	
	# try to keep all these colors in sync
	$Button.add_color_override("font_color", value)
	$Button.add_color_override("font_color_hover", value)
	$SelectedBefore.add_color_override("font_color", value)
	$SelectedAfter.add_color_override("font_color", value)
