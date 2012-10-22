function loadMap(path)
  love.filesystem.load(path)()
end

--[[
Initialise a map. (Must be called in the map definition file.)
--]]
function newMap(sunFile, planets)
   generateStarField()

   Sun = love.graphics.newImage(sunFile)

   -- Load images for planets
   Planets = {}
   for i=1, #planets do
      Planets[i] = planets[i]
      Planets[i][1] = love.graphics.newImage(planets[i][1])
   end

   -- Caculates position of the sun (Middle of window)
   SunXPos = (love.graphics.getWidth() - Sun:getWidth()) / 2
   SunYPos = (love.graphics.getHeight() - Sun:getHeight()) / 2
end

--[[
Draw the map we've loaded
--]]
function drawMap()
   -- Draw stars
   for i=1, #Stars do
      love.graphics.setColorMode("replace")
      love.graphics.setColor(255,255,255)
      love.graphics.point(Stars[i][1], Stars[i][2])
   end
   
   -- Draw the sun.
   love.graphics.draw(Sun, SunXPos, SunYPos)

   -- Draw (and animate) planets.
   for i=1, #Planets do
      --[[
         Planets[i][1] = Planet's image
         Planets[i][2] = The planet-sun distance.
         Planets[i][3] = Planet's starting angle.
         Planets[i][4] = Planet's rotation speed.
      --]]
      planetX = SunXPos + Planets[i][2] * math.cos(Planets[i][3])
      planetY = SunYPos + Planets[i][2] * math.sin(Planets[i][3])
      Planets[i][3] = Planets[i][3] + Planets[i][4]; -- Incrementing angle with speed.
      love.graphics.draw(Planets[i][1], planetX, planetY)
   end
end

--[[
Generate an array of coordinates (x,y) for stars to draw.
--]]
function generateStarField()
   Stars = {}
   max_stars = 100
   -- Generates random coordinates for stars.
   for i=1, max_stars do
      Stars[i] = {
         math.random(5, love.graphics.getWidth()-5), 
         math.random(5, love.graphics.getHeight()-5)
      }
   end
end

