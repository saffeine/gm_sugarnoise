window_set_size(280 * 3, 280 * 3);
function SugarNoise(_width, _height) constructor {
	width		= _width;
	height		= _height;
	noiseMap	= [];
	
	generateMap	= function(){
		for(var i=0; i<width*height; i++){
			noiseMap[i]		= {
				value:	1,
				angle:	(random(360))
			};
		}
	};
	
	get			= function(_x, _y){
		var _ix		= floor(_x);	// integer x.
		var _iy		= floor(_y);	// integer y.
		var _lx		= _x - _ix;		// lerp x.
		var _ly		= _y - _iy;		// lerp y.
		
		var _aa		= getStruct(_ix, _iy);
		var _ba		= getStruct(_ix + 1, _iy);
		var _ab		= getStruct(_ix, _iy + 1);
		var _bb		= getStruct(_ix + 1, _iy + 1);
		
		var _aw		= lerp(dcos(_aa.angle), dcos(_ba.angle), _lx);
		var _ah		= lerp(dsin(_aa.angle), dsin(_ba.angle), _lx);
		var _bw		= lerp(dcos(_ab.angle), dcos(_bb.angle), _lx);
		var _bh		= lerp(dsin(_ab.angle), dsin(_bb.angle), _lx);
		var _cw		= (1 + lerp(_aw, _bw, fade(_ly))) / 2;
		var _ch		= (1 + lerp(_ah, _bh, fade(_ly))) / 2;
		var _result	= ((_cw + _ch)) / 2;
		
		return _result;
	};
	
	getStruct	= function(_x, _y){
		_x		= (_x % width);
		_y		= (_y % height);
		return noiseMap[(_y * width) + _x];
	};
	
	drawNoise	= function(_x, _y){
		var _spanX		= 16;
		var _spanY		= 16;
		
		for(var i=0; i<width; i+=(1/_spanX)){
		for(var j=0; j<height; j+=(1/_spanY)){
			var _xx		= _x + (i*_spanX);
			var _yy		= _y + (j*_spanY);
			var _level	= (get(i, j)) * 255;
			draw_set_color(make_color_rgb(_level, _level, _level));
			draw_point(_xx, _yy);
		};
		};
	};
	
	drawAngles	= function(_x, _y){
		for(var i=0; i<width*height; i++){
			var _ix		= floor(i % width);
			var _iy		= floor(i / width);
			var _ax		= (_ix * 16);
			var _ay		= (_iy * 16);
			var _bx		= (_ax + (dcos(noiseMap[i].angle) * (noiseMap[i].value * 16)));
			var _by		= (_ay + (dsin(noiseMap[i].angle) * (noiseMap[i].value * 16)));
			
			draw_set_color(c_red);
			draw_line(_x + _ax, _y + _ay, _x + _bx, _y + _by);
		} return;
	};
	
	generateMap();
}

function Vec2(_x, _y) constructor {
	x	= _x;
	y	= _y;
}

function fade(_t){
	return 1-((dcos(_t*180)+1) / 2);
}

function main(){
	static __ = undefined;
	if(__ == undefined){
		noise = (new SugarNoise(16, 16));
		noise1 = (new SugarNoise(32, 32));
		noise2 = (new SugarNoise(64, 64));
		__	= true; return;
	}
	
	var _scale	= 32;
	for(var i=0; i<8; i+=(1/_scale)){
	for(var j=0; j<8; j+=(1/_scale)){
		var _mx = (mouse_x - 4);
		var _my = (mouse_y - 4);
		
		var _level	= ((noise.get(i, j) + noise1.get(i*2.153, j*2.1782) + noise2.get(i*2.653, j*2.6782)) / 3) * 10;
		
		var _colour = c_navy;
		if(_level > 2){ _colour = c_blue; }
		if(_level > 4){ _colour = c_teal; }
		if(_level > 4.33){ _colour = c_green; }
		if(_level > 4.66){ _colour = c_lime; }
		if(_level > 8){ _colour = c_silver; }
		if(_level > 9){ _colour = c_white; }
		
		draw_set_color(_colour);
		draw_point(4 + (i*_scale), 4 + (j*_scale));
	}
	}
}