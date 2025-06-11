extends RayCast3D


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"): 
		try_interact()


func try_interact(): 
	if !is_colliding(): return 
	if !get_collider() is Interactable: return 
	
	var interactable: Interactable = get_collider()
	interactable.interacted.emit()
