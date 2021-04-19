shader_type canvas_item;
uniform vec2 player_position;
uniform vec4 color : hint_color = vec4(0.305, 0.298, 0.341,1);

uniform float MULTIPLIER = 0.56;
uniform float SCALE = 0.5;
uniform float SOFTNESS = 0.65;


float circle(vec2 position, float radius, float feather)
{
	return smoothstep(radius, radius + feather, dot(position, position ) * 8.0);
}

float vigTypeB(vec2 dude){
	float vignette = circle(dude - vec2(player_position.x,player_position.y ), 0.1, 0.5);
	return vignette;
}

float vigTypeA(vec2 dude){
	float val = distance(vec2(dude.x , dude.y * MULTIPLIER), vec2(player_position.x , player_position.y * MULTIPLIER));
	val = val / SCALE;
	float vignette = smoothstep(0.2, SOFTNESS, val);
	return vignette;
}

void fragment(){
	COLOR = vec4(color.rgb , vigTypeA(UV));
}




