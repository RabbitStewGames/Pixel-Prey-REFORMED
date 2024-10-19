function Vector2(_x, _y) constructor
{
	x = _x
	y = _y
	
	magnitude = function()
	{
		var vx = vec.x
		var vy = vec.y
		
		var len = sqrt(sqr(vx) + sqr(vy))
		
		return len
	}
	
	sqrMagnitude = function()
	{
		var vx = vec.x
		var vy = vec.y
		
		var len = sqr(vx) + sqr(vy)
		
		return len
	}
	
	static Distance = function(v1, v2)
	{
		var vx = v1.x - v2.x
		var vy = v1.y - v2.y
		
		var len = sqrt(sqr(vx) + sqr(vy))
		
		return len
	}
	
	static Normalize = function(vec)
	{
		var vx = vec.x
		var vy = vec.y
		
		var len = sqrt(sqr(vx) + sqr(vy))
		
		vx = (vx/len)
		vy = (vy/len)
		
		return new Vector2(vx,vy)
	}
	
	static Add = function(_vec1, _vec2)
	{
		_newx = _vec1.x + _vec2.x
		_newy = _vec1.y + _vec2.y
		
		return new Vector2(_newx, _newy)
	}
	
	static Subtract = function(_vec1, _vec2)
	{
		_newx = _vec1.x - _vec2.x
		_newy = _vec1.y - _vec2.y
		
		return new Vector2(_newx, _newy)
	}
	
	static Multiply = function(_vec1, _vec2)
	{
		_newx = _vec1.x * _vec2.x
		_newy = _vec1.y * _vec2.y
		
		return new Vector2(_newx, _newy)
	}
	
	static MultiplyReal = function(_vec1, _num)
	{
		_newx = _vec1.x * _num
		_newy = _vec1.y * _num
		
		return new Vector2(_newx, _newy)
	}
	
	static Lerp = function(from, to, t)
	{
		_newX = lerp(from.x, to.x, t)	
		_newY = lerp(from.y, to.y, t)
		
		return new Vector2(_newx, _newy)
	}
	
	static Divide = function(_vec1, _vec2)
	{
		_newx = _vec1.x / _vec2.x
		_newy = _vec1.y / _vec2.y
		
		return new Vector2(_newx, _newy)
	}
	
	static DirectionTo = function(_origin, _target)
	{
		var diff = Vector2.Subtract(_target, _origin)
		var norm = Vector2.Normalize(diff)
		
		return norm
	}
	
	static Dot = function(_vec1, _vec2)
	{
		return dot_product(_vec1.x, _vec1.y, _vec2.x, _vec2.y)	
	}
}