function Health(verticalOffset)

	local _health = 100
	local _maxHealth = 100
	local _hitSplashes = {}
	local _damageToTake = {}
	local _x = 0
	local _y = 0

	local _computeDamage = function()
		for key, damage in pairs(_damageToTake) do

			_health = _health - damage
			table.remove(_damageToTake, key)
			table.insert(_hitSplashes, HitSplash(-damage, _x, _y))

			if _health < 0 then
				_health = 0
			end
		end
	end

	local _updateHitSplashes = function(dt)
		for key, hitsplash in pairs(_hitSplashes) do
			hitsplash.update(dt)
			if (hitsplash.getDuration() <= 0) then
				table.remove(_hitSplashes, key)
			end
		end
	end

	local _renderHitSplashes = function()
		for key, hitsplash in pairs(_hitSplashes) do
			hitsplash.draw()
		end
	end


	local _heal = function (value)
		if _maxHealth >= _health + value then
			_health = _health + value
			table.insert(_hitSplashes, HitSplash(value, _x, _y))
		end
	end

	local _insertDamage = function(value)
		if _health > 0 then
			table.insert(_damageToTake, value)
		end
	end

	local _isDead = function()
		return _health <= 0
	end

	function update(dt, x, y)
		_x = x
		_y = y
		_updateHitSplashes(dt)
		_computeDamage()
	end

	function draw()
		renderHealthBar(_health / _maxHealth, _x, _y - verticalOffset)
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