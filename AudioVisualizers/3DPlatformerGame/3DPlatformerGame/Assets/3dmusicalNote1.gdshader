shader_type spatial;
render_mode unshaded;

global uniform sampler2D spectrumtexture;
uniform sampler2D albedo: source_color;

varying float spectrum_value;
varying float random_number;

void vertex() {
	// Called for every vertex the material is visible on.
	vec3 nw = NODE_POSITION_WORLD;
	random_number = nw.x * 23.234 + nw.y * 43.6578 + nw.z * 12.567;
	random_number = fract(random_number);
	spectrum_value = texture(spectrumtexture,vec2(random_number,0)).r;
	VERTEX *= 1.0 + spectrum_value;
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = texture(albedo, UV,1 ).rgb;
	ALBEDO = vec3(random_number);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
