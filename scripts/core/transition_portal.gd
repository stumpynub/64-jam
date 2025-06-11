class_name TransitionPortal extends Area3D

@export var scene_uid: String


func _ready() -> void:
	body_entered.connect(_body_entered)


func _body_entered(body): 
	if body is Player: 
		queue_transition()


func queue_transition(): 
	if scene_uid == null: return 
	var error = get_tree().change_scene_to_file(scene_uid)
	
	if error != OK: 
		print("cannot open scene")
		
