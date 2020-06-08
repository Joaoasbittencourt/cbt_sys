Loader = {}

local tilesPath = "assets/tiles/"

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

	function map:draw()
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