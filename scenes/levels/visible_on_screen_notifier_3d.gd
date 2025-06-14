extends VisibleOnScreenNotifier3D

@onready var fear_meter = $"../../../CharacterBody3D/UI"

func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	fear_meter._updateFearMeter(15, 2)

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	print("exited")
