function Vector(x, y)

	local self = {}
	local _x = x or 0
	local _y = y or 0

	local function getModulus()
		return math.sqrt(math.pow(_x, 2) + math.pow(_y, 2))
	end

	local function add(point)
		return Vector(_x + point.getX(),  _y + point.getY())
	end

	local function mul(value)
		return Vector(_x * value, _y * value)
	end

	local function sub(vec)
		return Vector(_x - vec.getX(), _y - vec.getY())
	end

	local function set(point)
		_x = point.getX()
		_y = point.getY()
	end

	local function getUnit()
		local mod = getModulus()
		return Vector(_x / mod, _y / mod)
	end

	self.add = add
	self.mul = mul
	self.set = set
	self.sub = sub
	self.getUnit = getUnit
	self.getModulus = getModulus
	self.getX = function() return _x end
	self.getY = function() return _y end

	return self
end