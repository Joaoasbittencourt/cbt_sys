
function DamageArea(value, x, y, size)

	local position = Vector(x, y)
	local _value = value or 0

	local function draw()
		love.graphics.setColor(1, 0, 1);
		love.graphics.circle("fill", position.getX(), position.getY(), size)
	end

	local function computeDamage(damageable)
		damageable.insertDamage(_value)
	end

	return {
		draw = draw,
		computeDamage = computeDamage,
		getRadius = function() return size end,
		getX = position.getX,
		getY = position.getY
	}
end