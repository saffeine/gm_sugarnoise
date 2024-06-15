var _scale	= 128;

for(var i=0; i<4; i+=(1/_scale)){
for(var j=0; j<4; j+=(1/_scale)){
	var _mx = (mouse_x - 4);
	var _my = (mouse_y - 4);
		
	var _level	= (
		(noise.get(i, j) + noise1.get(i*2.153, j*2.1782) +
		noise2.get(i*2.653, j*2.6782)) / 3) * 10;
		
	var _colour = [
		make_color_rgb(0, 0, 80),
		make_color_rgb(0, 0, 80),
		make_color_rgb(0, 40, 120),
		make_color_rgb(0, 80, 160),
		make_color_rgb(200, 160, 80),
		make_color_rgb(20, 140, 0),
		make_color_rgb(60, 180, 0),
		make_color_rgb(80, 225, 0),
		make_color_rgb(225, 225, 225),
		make_color_rgb(255, 255, 255)
	][round(_level)];
		
	draw_set_color(_colour);
	draw_point(4 + (i*_scale), 4 + (j*_scale));
}
}