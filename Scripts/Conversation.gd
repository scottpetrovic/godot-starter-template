extends Node2D

signal messageEnded

func _ready():
	# configure timer to show message for X seconds
	$Timer.one_shot = true
	$Timer.connect("timeout", Callable(self, "_timeout"))

func showConversation(textToShow, length = 3.0):
	$RichTextLabel.text = textToShow
	$Timer.wait_time = length
	$Timer.start()
	self.visible = true
	
func _timeout():
	self.visible = false;
	emit_signal("messageEnded")
