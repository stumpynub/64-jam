extends Node3D
@onready var animation = $"small enemy/AnimationPlayer"

func _ready() -> void:
	_idle()

func _run():
	animation.play("run")

func _idle():
	animation.play("idle")
