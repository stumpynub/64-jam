extends Node3D

#nodes
@export_group("Nodes")


#Settings.
@export_group("Settings")

#Mouse settings.
@export_subgroup("Mouse settings")

#mouse sensitivity.
@export_range(1, 100, 1) var mouse_sensitivity: int = 50

#pitch clamp settings.
@export_subgroup("Clamp settings")

#max pitch in degrees.
@export var max_pitch : float = 85

#min pitch in degrees.
@export var min_pitch : float = -85


var zoomed_in = false
var zoom_fov = 35
var default_fov = 90
var zoom_tween: Tween


func _ready():
	Input.set_use_accumulated_input(false)


func _unhandled_input(event)->void:
	
	if Input.is_action_just_pressed("zoom"): 
		toggle_zoom()
	
	
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		if event is InputEventKey:
			if event.is_action_pressed("ui_cancel"):
				get_tree().quit()
		 
		if event is InputEventMouseButton:
			if event.button_index == 1:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
		return
	
	if event is InputEventKey:
		if event.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
		return
	
	if event is InputEventMouseMotion:
		aim_look(event)


func _process(delta: float) -> void:
	global_rotation.x = clamp(global_rotation.x, deg_to_rad(min_pitch), deg_to_rad(max_pitch))

#Handles aim look with the mouse.
func aim_look(event: InputEventMouseMotion)-> void:
	var viewport_transform: Transform2D = get_tree().root.get_final_transform()
	var motion: Vector2 = event.xformed_by(viewport_transform).relative
	var degrees_per_unit: float = 0.001
	
	motion *= mouse_sensitivity
	motion *= degrees_per_unit
	rotation.z = 0
	add_yaw(motion.x)
	add_pitch(motion.y)


#Rotates the character around the local Y axis by a given amount (In degrees) to achieve yaw.
func add_yaw(amount)->void:
	if is_zero_approx(amount):
		return
	
	rotate_object_local(Vector3.DOWN, deg_to_rad(amount))


#Rotates the head around the local x axis by a given amount (In degrees) to achieve pitch.
func add_pitch(amount)->void:
	if is_zero_approx(amount):
		return
	
	rotate_object_local(Vector3.LEFT, deg_to_rad(amount))
	orthonormalize()


func toggle_zoom():
	var cam = get_viewport().get_camera_3d()
	zoomed_in = !zoomed_in
	
	if zoom_tween != null: 
		zoom_tween.kill()
	
	zoom_tween = create_tween()
	
	if zoomed_in: 
		zoom_tween.tween_property(
			cam,
			"fov", 
			zoom_fov, 
			0.2
		)
	else: 
		zoom_tween.tween_property(
			cam,
			"fov", 
			default_fov, 
			0.2
		)
