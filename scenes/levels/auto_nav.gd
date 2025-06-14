@tool
extends NavigationRegion3D

@export var generate_wait_time = 1.0 : 
	get(): 
		return generate_wait_time
	set(v): 
		generate_wait_time = v
		if timer: 
			timer.wait_time = v

var timer: Timer = Timer.new()


func _ready() -> void:
	if !Engine.is_editor_hint(): return 
	add_child(timer)
	timer.wait_time = generate_wait_time
	timer.one_shot = false 
	timer.start()
	
	timer.timeout.connect(func(): if !is_baking(): bake_navigation_mesh())
