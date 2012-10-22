function loadTowers(towers)
   TooltipFont = love.graphics.newFont(12)
   Towers = {}

   for i=1, #towers do
      Towers[i] = love.filesystem.load(towers[i])()
      Towers[i].image = love.graphics.newImage(Towers[i].imageUrl)
   end
   CalculatedTowersPosition = false
end

--[[
Draw towers.
We keep coordinates :
Towers[i].menuX = X coordinate of down menu
Towers[i].menuY = Y coordinate of down menu
--]]
function drawTowers()
   -- Calculates tours' position (in menu), if not already done.
   if not CalculatedTowersPosition then
      for i=1, #Towers do
         towerHeight = Towers[i].image:getHeight()
         towerWidth = Towers[i].image:getWidth()

         Towers[i].menuX = (i-1)*towerWidth
         Towers[i].menuY = love.graphics.getHeight() - towerHeight
         
      end
      CalculatedTowersPosition = true
   end

   -- Show towers (in menu)
   for i=1, #Towers do
      love.graphics.draw(Towers[i].image, Towers[i].menuX, Towers[i].menuY)
   end
   
   -- Show information tooltip on menu item hover
   tower = getTower(love.mouse.getX(), love.mouse.getY())
   if tower ~= nil then
      drawTowerDetails(tower, love.mouse.getX(), love.mouse.getY())
   end
   
end

--[[
Get information about the tower menu item found at given coordinates.
--]]
function getTower(x, y)
   for i=1, #Towers do

      if (x >= Towers[i].menuX) and (x <= (Towers[i].menuX + Towers[i].image:getWidth())) and (y >= Towers[i].menuY) and (y <= (Towers[i].menuY + Towers[i].image:getHeight())) then
         return Towers[i]
      end
   end
end

function drawTowerDetails(tower, mouseX, mouseY)
   tooltipPadding = 10
   textTopMargin = 2

   -- Tooltip width is determined by the tour name's width. (min 100 px)
   rectWidth = TooltipFont:getWidth(tower.name) + tooltipPadding*2
   if rectWidth < 100 then
      rectWidth = 100 
   end
   rectHeight = 100

   rectX = mouseX
   rectY = mouseY - rectHeight

   love.graphics.setColorMode("replace")
   love.graphics.setColor(255,255,255)
   love.graphics.rectangle("fill", rectX, rectY, rectWidth, rectHeight)
   if tower.fireRate == nil then
      tower.fireRate = ""
   end

   fontHeight = TooltipFont:getHeight()

   -- Prepare font.
   love.graphics.setFont(TooltipFont)
   love.graphics.setColorMode("modulate")
   love.graphics.setColor(0, 0, 255)

   -- Show tower name.
   love.graphics.printf(tower.name, rectX, rectY + tooltipPadding, rectWidth, "center")

   -- Show other details.
   detailsStart = rectY + tooltipPadding*2 + fontHeight
   love.graphics.print("Fire Rate: " .. tower.fireRate, rectX + tooltipPadding, detailsStart)
   love.graphics.print("Damage: " .. tower.damage, rectX + tooltipPadding, detailsStart + textTopMargin + fontHeight)
end
















