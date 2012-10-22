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
Dessiner les tours.
On conserve les coordonnées :
Towers[i].menuX = Position en X au menu en bas
Towers[i].menuY = Position en Y
--]]
function drawTowers()
   -- Calculer la position des tours (dans le menu), si ce n'est pas déjà fait.
   if not CalculatedTowersPosition then
      for i=1, #Towers do
         towerHeight = Towers[i].image:getHeight()
         towerWidth = Towers[i].image:getWidth()

         Towers[i].menuX = (i-1)*towerWidth
         Towers[i].menuY = love.graphics.getHeight() - towerHeight
         
      end
      CalculatedTowersPosition = true
   end

   -- Affichage des tours (dans le menu)
   for i=1, #Towers do
      love.graphics.draw(Towers[i].image, Towers[i].menuX, Towers[i].menuY)
   end
   
   -- Si le curseur est sur l'élément de menu d'une tour, on afficher ses détails.
   tower = getTower(love.mouse.getX(), love.mouse.getY())
   if tower ~= nil then
      drawTowerDetails(tower, love.mouse.getX(), love.mouse.getY())
   end
   
end

--[[
Obtenir les details de la tour dont l'élément dans le menu se trouve aux coordonnées reçues.
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

   -- La largeur du tooltip est déterminé par la longueur du nom de la tour. (Minimum 100 pixels)
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

   -- Préparation du font.
   love.graphics.setFont(TooltipFont)
   love.graphics.setColorMode("modulate")
   love.graphics.setColor(0, 0, 255)

   -- Afficher le nom de la tour.
   love.graphics.printf(tower.name, rectX, rectY + tooltipPadding, rectWidth, "center")

   -- Afficher les autre détails.
   detailsStart = rectY + tooltipPadding*2 + fontHeight
   love.graphics.print("Fire Rate: " .. tower.fireRate, rectX + tooltipPadding, detailsStart)
   love.graphics.print("Damage: " .. tower.damage, rectX + tooltipPadding, detailsStart + textTopMargin + fontHeight)
end
















