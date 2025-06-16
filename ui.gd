
extends Control

signal fear_meter_decrease
signal fear_meter_increase
signal unpause
@onready var fearMeter = $fearMeter
@onready var pauseMenu = $pauseMenu
@onready var fearmultiplier = 1

var target = 20



func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		if get_tree().paused:
			get_tree().paused = false
	
#managing the fear meter's progression
func _increaseFearMeter(value, distance) -> void:

	#Creates the multiplier to change the rate the meter fills
	if fearMeter.value <= 25:
		fearmultiplier = 2.5
	elif fearMeter.value < 75:
		fearmultiplier = 1.5
	elif fearMeter.value < 90:
		fearmultiplier = 2
		
	if fearMeter.value <= 90:
		var tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_QUART)
		tween.tween_property(fearMeter, "value", 100, distance * fearmultiplier)
	#After 90, the tween slows down too much. Increment to 100
	else: 
		fearMeter.value = fearMeter.value + 1
#managing the fear meter's progression


func _decreaseFearMeter() -> void:
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(fearMeter, "value", 0, 10)


func _pauseMenu(value):
	if value == true:
		pauseMenu.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif value == false:
		pauseMenu.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
