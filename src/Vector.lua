function Vector(x, y)

	local self = {}
	local _x = x or 0
	local _y = y or 0

	local function getModulus() return math.sqrt(math.pow(_x, 2) + math.pow(_y, 2)) end
	local function mul(scalar) return Vector(_x * scalar, _y * scalar) end
	local function div(scalar) return Vector(_x / scalar, _y / scalar) end
	local function add(vec) return Vector(_x + vec.getX(),  _y + vec.getY()) end
	local function sub(vec) return Vector(_x - vec.getX(), _y - vec.getY()) end
	local function getUnit() return Vector(_x, _y).div(getModulus()) end
	local function directionTo(point) return point.sub(self).getUnit() end
	local function distanceTo(point) return self.sub(point).getModulus() end

	local function set(point)
		_x = point.getX()
		_y = point.getY()
	end

	self.directionTo = directionTo
	self.distanceTo = distanceTo
	self.div = div
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