class_name UI
extends Control

signal fear_meter_decrease
signal fear_meter_increase
signal unpause
@onready var fearMeter = $fearMeter
@onready var pauseMenu = $pauseMenu

func _ready() -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		if get_tree().paused:
			get_tree().paused = false

#managing the fear meter's progression
func _updateFearMeter(value, acceleration) -> void:
	fearMeter.value = fearMeter.value + (value * acceleration)

func _pauseMenu(value):
	if value == true:
		pauseMenu.visible = true
		#pauseMenu.mouse_filter = MOUSE_FILTER_STOP
		print("Entered true")
		print(pauseMenu.mouse_filter)
	else:
		pauseMenu.visible = false
		#pauseMenu.mouse_filter = MOUSE_FILTER_IGNORE
		unpause.emit()
		print("Entered false")
		print(pauseMenu.mouse_filter)
