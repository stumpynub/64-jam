extends Node3D

@export var max_fps = 24


func _ready() -> void:
	Engine.max_fps = max_fps
