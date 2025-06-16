extends AudioStreamPlayer3D

@export var player: CharacterBody3D

var step_timer: Timer = Timer.new()
var ray: RayCast3D = RayCast3D.new()

var A

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	step_timer.wait_time = 0.4
	step_timer.timeout.connect(_timeout)
	add_child(step_timer)
	add_child(ray)
	ray.target_position = Vector3.DOWN * 3


func _process(delta: float) -> void:
	if player.velocity.length() > 0 and player.is_on_floor() && step_timer.is_stopped(): 
		step_timer.start()
	
	if player.velocity.length() <= 0 and !step_timer.is_stopped(): 
		step_timer.stop()

	if ray.is_colliding(): 
		var groups = ray.get_collider().get_groups()


func _timeout(): 
	play()
