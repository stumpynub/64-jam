extends Node3D

@onready var fear_meter = $"../../../CharacterBody3D/UI"
@onready var player = $CharacterBody3D

func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	player.seenspooky()


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	print("exited")
