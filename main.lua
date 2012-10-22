require 'mechanics/map-helper'
require 'mechanics/towers'

function love.load()
   love.filesystem.load('content/level1.lua')()
end

function love.draw()
   drawMap()
   drawTowers()
end
