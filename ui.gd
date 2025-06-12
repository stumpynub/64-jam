class_name UI
extends Control

signal fear_meter_decrease
signal fear_meter_increase
@onready var fearMeter = $fearMeter


func _ready() -> void:
	pass

#managing the fear meter's progression
func _updateFearMeter(value, acceleration) -> void:
	fearMeter.value = fearMeter.value + (value * acceleration)
