extends Control

@export var start_level_uid: String

func _on_start_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if ResourceLoader.get_resource_uid(start_level_uid) == -1: return 
	SceneTransition.change_scene(start_level_uid)
