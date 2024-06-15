function SugarNoise(_width, _height) constructor {
	/*	define variables. */
	width		= _width;
	height		= _height;
	noiseMap	= [];
	
	/*	fade/ease function, for smoother edges weighted towards 0 & 1. */
	__fade		= function(_t){
		return 1-((dcos(_t*180)+1) / 2);
	};
	
	/*	populate the noiseMap array with random angle values (in degrees). */
	generateMap	= function(){
		for(var i=0; i<width*height; i++){
			noiseMap[i]	= random(360);
		} return;
	};
	
	/*	return the value at a given location. */
	get			= function(_x, _y){
		var _ix		= floor(_x);	// integer x, the floor value of the _x coord.
		var _iy		= floor(_y);	// integer y, the floor value of the _y coord.
		var _lx		= __fade(_x - _ix);		// lerp x, the remainder value of the _x coord, put through the fade function.
		var _ly		= __fade(_y - _iy);		// lerp y, the remainder value of the _y coord, put through the fade function.
		
		var _aa		= getAngle(_ix, _iy);			//	return the angles of all four corner points of the "cell".
		var _ba		= getAngle(_ix + 1, _iy);		//	the letters A/B refer to the X/Y positions respectively.
		var _ab		= getAngle(_ix, _iy + 1);		//	AA	|	BA
		var _bb		= getAngle(_ix + 1, _iy + 1);	//	AB	|	BB
		
		var _aw		= lerp(dcos(_aa), dcos(_ba), _lx);	//	interpolate the top-left/top-right cosine values.
		var _ah		= lerp(dsin(_aa), dsin(_ba), _lx);	//	interpolate the top-left/top-right sine values.
		var _bw		= lerp(dcos(_ab), dcos(_bb), _lx);	//	interpolate the bottom-left/bottom-right cosine values.
		var _bh		= lerp(dsin(_ab), dsin(_bb), _lx);	//	interpolate the bottom-left/bottom-right sine values.
		var _cw		= (1 + lerp(_aw, _bw, _ly)) / 2;	//	interpolate the cosine values, add one & divide by 2 to give a value between 0-1.
		var _ch		= (1 + lerp(_ah, _bh, _ly)) / 2;	//	interpolate the sine values, add one & divide by 2 to give a value between 0-1.
		var _result	= ((_cw + _ch)) / 2;				//	finally, return the sum of the cosine and sine values, divided by two to give a value between 0-1.
		
		return _result;
	};
	
	/*	return the angle at a given cell position. */
	getAngle	= function(_x, _y){
		_x		= (_x % width);		//	perform modulo on the _x value in order to wrap it around the width.
		_y		= (_y % height);	//	perform modulo on the _y value in order to wrap it around the height.
		return noiseMap[(_y * width) + _x];		// return the angle value at that point within the noiseMap.
	};
	
	generateMap();
}