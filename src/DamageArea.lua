
function DamageArea(value, x, y, size)

	local _x = x or 0
	local _y = y or 0
	local _value = value or 0

	local function draw()
		love.graphics.setColor(1, 0, 1);
		love.graphics.circle("fill", _x, _y, size)
	end

	local function computeDamage(damageable)
		damageable.insertDamage(_value)
	end

	return {
		draw = draw,
		computeDamage = computeDamage,
		getRadius = function() return size end,
		getX = function() return _x end,
		getY = function() return _y end,
	}
end