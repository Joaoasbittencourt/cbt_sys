function Vector(x, y)

	local self = {}
	local _x = x or 0
	local _y = y or 0

	local function getModulus()
		return math.sqrt(math.pow(_x, 2) + math.pow(_y, 2))
	end

	local function add(point)
		_x = _x + point.getX()
		_y = _y + point.getY()
		return self
	end

	local function mul(value)
		_x = _x * value
		_y = _y * value
		return self
	end

	local function set(point)
		_x = point.x
		_y = point.y
	end

	function getUnit()
		local mod = getModulus()
		return Vector(_x / mod, _y + mod)
	end

	self.add = add
	self.mul = mul
	self.getUnit = getUnit
	self.getModulus = getModulus
	self.set = set
	self.getX = function() return _x end
	self.getY = function() return _y end

	return self
end