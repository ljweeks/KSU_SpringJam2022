shader_type spatial;
render_mode unshaded, cull_front;

uniform bool enable = true; // on and off switsch to diesable/enable the outline
// outline costumization
uniform float outline_thickness = 5.0; // how thick is the outline?
uniform vec4 color : hint_color = vec4(1, 1, 1, 1); // which color does the outline have?



void vertex() {
	if (enable) {
	VERTEX += NORMAL * 0.1 //* outline_thickness; // apply the outlines thickness	
	}
}

void fragment() {
	if (enable) {
		ALBEDO = vec3(0.843,0.012,0.988);
		EMISSION = vec3(0.843,0.012,0.988);
	}
}