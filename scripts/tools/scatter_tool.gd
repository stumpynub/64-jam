@tool class_name ScatterTool extends Node3D

@export var scene_uid: String
@export var amount = 100
@export var radius = 10
@export var normal: Vector3

@export_tool_button('scatter') var scatter = _scatter
@export_tool_button('clear') var clear = _clear

@export var min_scale: float = 1.0
@export var max_scale: float = 1.0

@export_group("rotation settings")
@export var rotate_to_normal = false
@export_range(-360, 360) var min_x_rotation: float = 0.0
@export_range(-360, 360) var max_x_rotation: float = 0.0

@export_range(-360, 360) var min_y_rotation: float = 0.0
@export_range(-360, 360) var max_y_rotation: float = 0.0

@export_range(-360, 360) var min_z_rotation: float = 0.0
@export_range(-360, 360) var max_z_rotation: float = 0.0

@export var exlude_groups: Array[String]


var ray_length = 50


func _scatter(): 
	if !ResourceLoader.exists(scene_uid): return 
	
	var scatter_count = 0 
	
	while scatter_count < amount: 
		var pos = global_position + Vector3(randf_range(-radius, radius), 0, randf_range(-radius, radius))
		var state = get_world_3d().direct_space_state
		var params = PhysicsRayQueryParameters3D.new()
		params = params.create(pos, pos + Vector3(0, -100,0),)
		var coll = state.intersect_ray(params)
		
		if coll.size() <= 0:
			continue
			 
		var coll_normal: Vector3 = coll.normal 
		var in_excluded = false
		
		for group in exlude_groups: 
			print(coll.collider.owner.name)
			if coll.collider.owner.is_in_group(group): 
				in_excluded = true
		if in_excluded: 
			continue
		
		var scene = ResourceLoader.load(scene_uid)
		var inst = scene.instantiate()
		add_child(inst)
		
		if rotate_to_normal: 
			var y = coll_normal.normalized()

			# Pick an arbitrary vector that is not parallel to y
			var tangent = Vector3(0, 1, 0)
			var x = tangent.cross(y).normalized()
			var z = y.cross(x).normalized()

			inst.global_basis = Basis(x, y, -z)
			
		inst.owner = get_tree().edited_scene_root
		inst.global_position = coll.position
		inst.scale = Vector3.ONE * randf_range(min_scale, max_scale)
		
		inst.rotation_degrees.x += randf_range(min_x_rotation, max_x_rotation)
		inst.rotation_degrees.y += randf_range(min_y_rotation, max_y_rotation)
		inst.rotation_degrees.z += randf_range(min_z_rotation, max_z_rotation)
		scatter_count += 1

func _clear(): 
	for child in get_children(): 
		child.queue_free()
