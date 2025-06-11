shader_type spatial;

uniform sampler2D n1; 

void vertex() {
	vec4 c1 = texture(n1, UV); 
	
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
