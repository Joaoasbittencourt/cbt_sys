function HealthComponent(verticalOffset, name)

	local _health = 100
	local _maxHealth = 100
	local _hitSplashes = {}
	local _damageToTake = {}
	local _x = 0
	local _y = 0

	local function _computeDamage()
		for key, damage in pairs(_damageToTake) do

			_health = _health - damage
			table.remove(_damageToTake, key)
			table.insert(_hitSplashes, HitSplashEntity:new(-damage, _x, _y))

			if _health < 0 then
				_health = 0
			end
		end
	end

	local function _updateHitSplashes(dt)
		for key, hitsplash in pairs(_hitSplashes) do
			hitsplash:update(dt)
			if (hitsplash.duration <= 0) then
				table.remove(_hitSplashes, key)
			end
		end
	end

	local function _renderHitSplashes()
		for key, hitsplash in pairs(_hitSplashes) do
			hitsplash:draw()
		end
	end

	local function _heal(value)
		if _maxHealth >= _health + value then
			_health = _health + value
			table.insert(_hitSplashes, HitSplash:new(value, _x, _y))
		end
	end

	local function _insertDamage(value)
		if _health > 0 then
			table.insert(_damageToTake, value)
		end
	end

	local function _isDead()
		return _health <= 0
	end

	local function update(dt, x, y)
		_x = x
		_y = y
		_updateHitSplashes(dt)
		_computeDamage()
	end

	local function draw()
		renderHealthBar(_health / _maxHealth, _x, _y - verticalOffset, name)
		_renderHitSplashes()
	end

	return {
		update = update,
		draw = draw,
		isDead = _isDead,
		insertDamage = _insertDamage,
		heal = _heal
	}
end