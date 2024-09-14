extends CanvasLayer

signal start_game

func _on_start_button_pressed():
	#unload button and message later?
	$StartButton.hide()
	start_game.emit()
	$Message.hide()
