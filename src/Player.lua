function Player()

	local _id = 1
	local _name = "João Pedro"
	local _health = 100
	local _maxHealth = 100
	local _radius = 30
	local _x = 100
	local _y = 100
	local _speed = 200
	local _hitSplashes = {}
	local _damageToTake = {}

	local _isDead = function()
		return _health <= 0
	end

	local _move = function(dt)
		if _isDead() then
			return
		end

		local vertical = 0
		local horizontal = 0

		if love.keyboard.isDown('w') then vertical = -1 end
		if love.keyboard.isDown('s') then vertical = vertical + 1 end
		if love.keyboard.isDown('d') then horizontal = 1 end
		if love.keyboard.isDown('a') then horizontal = horizontal - 1 end

		_y = _y + vertical * _speed * dt
		_x = _x + horizontal * _speed * dt
	end

	local _insertDamage = function(value)
		if _health > 0 then
			table.insert(_damageToTake, value)
		end
	end

	local _computeDamage = function()
		for key, damage in pairs(_damageToTake) do

			_health = _health - damage
			table.remove(_damageToTake, key)
			table.insert(_hitSplashes, HitSplash(damage, _x, _y))

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

	local _renderHealthBar = function()
		renderHealthBar(_health / _maxHealth, _x, _y - _radius, _name)
	end

	local _update = function(dt)
		_move(dt)
		_updateHitSplashes(dt)
		_computeDamage()
	end

	local _render = function()
		love.graphics.setColor(0, 0, 1);
		love.graphics.circle("fill", _x, _y, _radius)
		love.graphics.setColor(0, 1, 0);
		_renderHealthBar()
		_renderHitSplashes()
	end

	local _heal = function (value)
		if _maxHealth >= _health + value then
			_health = _health + value
		end
	end

	return {
		insertDamage = _insertDamage,
		update = _update,
		render = _render,
		heal = _heal
	}
end
