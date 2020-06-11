Loader = {}

local tilesPath = "assets/tiles/"

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end


function Loader.loadTiledMap(path)
	local map = require(path)

	map.quads = {}

	local tileset = map.tilesets[1]

	local image = {
		width = tileset.imagewidth,
		height = tileset.imageheight,
	}

	local tile = {
		width = tileset.tilewidth,
		height = tileset.tileheight
	}

	map.tileset = tileset
	map.image = love.graphics.newImage(tilesPath .. tileset.image)
	map.collidableIds = {}

	map.getMapWidth = function()
		return map.width * map.tilewidth
	end

	map.getMapHeight = function()
		return map.height * map.tileheight
	end

	for y = 0, (image.height / tile.height) - 1 do
		for x = 0, (image.width / tile.width) - 1 do
			table.insert(
				map.quads,
				love.graphics.newQuad(
					x * tile.width,
					y * tile.height,
					tile.width,
					tile.height,
					image.width,
					image.height
				)
			)
		end
	end

	for key, ti in pairs(tileset.tiles) do
		local props = ti.properties or {}
		local col = props["collidable"] or false

		if (col) then
			table.insert(map.collidableIds, ti.id)
		end
	end

	for i, layer in ipairs(map.layers) do
		for y = 0, layer.height - 1 do
			for x = 0, layer.width - 1 do
				local index = (x + y * layer.width) + 1
				local tileId = layer.data[index]

				if tileId ~= 0 then
					local quad = map.quads[tileId]
					local xx = x * map.tileset.tilewidth
					local yy = y * map.tileset.tileheight
					love.graphics.draw(map.image, quad, xx, yy)

					if has_value(map.collidableIds, tileId) then
						local collider = world:newRectangleCollider(
							xx,
							yy,
							32,
							32
						)
						collider:setType("static")
					end
				end
			end
		end
	end

	function map:draw()
		love.graphics.setColor(1, 1, 1)
		for i, layer in ipairs(self.layers) do
			for y = 0, layer.height - 1 do
				for x = 0, layer.width - 1 do
					local index = (x + y * layer.width) + 1
					local tileId = layer.data[index]

					if tileId ~= 0 then
						local quad = self.quads[tileId]
						local xx = x * self.tileset.tilewidth
						local yy = y * self.tileset.tileheight
						love.graphics.draw(self.image, quad, xx, yy)
					end
				end
			end
		end
	end

	return map
end