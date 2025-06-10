class_name MainMenu
extends Control

@onready var options = $options_menu as OptionsMenu
@onready var margin_container = $MarginContainer as MarginContainer

func _ready() -> void:
	# Connect signal from options_menu to receive button presses
	options.return_menu.connect(_on_return_pressed)
	pass #options.return_menu.connect()
	

# Starts the game
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_proto_rail.tscn")

#Opens up options
func _on_options_pressed() -> void:
	print("Options Pressed")
	#enables functionality of options_menu
	options.set_process(true)
	margin_container.visible = false
	options.visible = true

# Button used from options_menu
func _on_return_pressed() -> void:
	print("Return Pressed")
	margin_container.visible = true
	options.visible = false
	# disables functionality of options_menu
	options.set_process(false)


#Quits the game
func _on_exit_pressed() -> void:
	get_tree().quit()
