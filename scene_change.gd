extends Node3D

@export var sceneUID: String


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("ENTERED")
	if ResourceLoader.get_resource_uid(sceneUID) == -1: return 
	SceneTransition.change_scene(sceneUID)
