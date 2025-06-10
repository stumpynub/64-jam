class_name OptionsMenu
extends Control

signal return_menu

func _ready():
	set_process(false)

func _on_return_pressed() -> void:
	#emits that this button was pressed
	return_menu.emit()
	set_process(false)


func _on_bustin_pressed() -> void:
	$AudioStreamPlayer2D.play()
	pass # Replace with function body.
