extends Path3D

@export var speed = 1
@export var follower: PathFollow3D


func _physics_process(delta: float) -> void:
	follower.progress += delta * speed
