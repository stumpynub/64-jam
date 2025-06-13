extends CharacterBody3D


@export var agent: NavigationAgent3D
@export var target: Node3D
@export var reached_distance= 4.0
@export var walk_speed = 5

func _physics_process(delta: float) -> void:
	agent.target_position = target.global_position
	
	var dist = agent.distance_to_target()
	
	if dist > reached_distance: 
		var next = agent.get_next_path_position()
		var vel = next - global_position 
		velocity = vel.normalized() * walk_speed
	else: 
		velocity = Vector3(0, velocity.y, 0) # stop horizontal movement 
		
	move_and_slide()


func tp_rand(): 
	var rand_point = NavigationServer3D.map_get_random_point(
		agent.get_navigation_map(), 
		agent.navigation_layers, true
		)


func tp_spook(): 
	var cam = get_viewport().get_camera_3d()
	var spook_dir = cam.global_basis.z * Vector3(1, 0, 1)
	var spook_point = NavigationServer3D.map_get_closest_point(
		agent.get_navigation_map(), 
		cam.global_position + spook_dir * 3
		)
