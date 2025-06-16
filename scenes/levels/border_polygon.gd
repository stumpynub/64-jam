@tool
extends CSGPolygon3D


@export_tool_button("generate") var generate_border = generate
@export var resolution: int = 1

var verts: PackedVector2Array

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func generate(): 
	verts = []
	
	for i in resolution: 
		var v1 = Vector2(0, 0) * resolution
		var v2 = Vector2(0, 10) * resolution
		var v3 = Vector2(1, 10) * resolution
		var v4 = Vector2(1, 0) * resolution
		
		verts.append(v1)
		verts.append(v2)
		verts.append(v3)
		verts.append(v4)
		
	polygon = verts
