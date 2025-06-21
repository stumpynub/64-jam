extends Node3D

@onready var smallcreature1 = $Path3D/PathFollow3D/small_creature
@onready var smallcreature2 = $Path3D/PathFollow3D2/small_creature
@onready var smallcreature3 = $Path3D/PathFollow3D3/small_creature
@onready var idlespot = 50
@onready var idlespot_add = true

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	const move_speed := 4.0
	smallcreature1._run()
	$Path3D/PathFollow3D.progress += move_speed * delta 
	if $Path3D/PathFollow3D.progress_ratio >= 0.965:
		smallcreature1.visible = false
	if $Path3D/PathFollow3D.progress_ratio >= 0.99:
		smallcreature1.visible = true
	smallcreature2._run()
	$Path3D/PathFollow3D2.progress += move_speed * delta * 2
	smallcreature3._run()
	$Path3D/PathFollow3D3.progress += move_speed * delta * 2.5
