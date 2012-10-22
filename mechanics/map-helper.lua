function loadMap(path)
  love.filesystem.load(path)()
end

--[[
Initialiser une map. (À appeler dans le fichier de définition d'une map.)
--]]
function newMap(sunFile, planets)
   generateStarField()

   Sun = love.graphics.newImage(sunFile)

   -- Charger les images pour les planetes.
   Planets = {}
   for i=1, #planets do
      Planets[i] = planets[i]
      Planets[i][1] = love.graphics.newImage(planets[i][1])
   end

   -- Calculer la position du soleil (Au milieu du jeux)
   SunXPos = (love.graphics.getWidth() - Sun:getWidth()) / 2
   SunYPos = (love.graphics.getHeight() - Sun:getHeight()) / 2
end

--[[
Dessiner la map en mémoire.
--]]
function drawMap()
   -- Dessiner les étoiles.
   for i=1, #Stars do
      love.graphics.setColorMode("replace")
      love.graphics.setColor(255,255,255)
      love.graphics.point(Stars[i][1], Stars[i][2])
   end
   
   -- Dessiner le soleil.
   love.graphics.draw(Sun, SunXPos, SunYPos)

   -- Dessiner (Animation) les planètes.
   for i=1, #Planets do
      --[[
         Planets[i][1] = L'image de la planète.
         Planets[i][2] = La distance entre la planète et le soleil.
         Planets[i][3] = L'angle de départ de la planète.
         Planets[i][4] = La vitesse de rotation de la planète.
      --]]
      planetX = SunXPos + Planets[i][2] * math.cos(Planets[i][3])
      planetY = SunYPos + Planets[i][2] * math.sin(Planets[i][3])
      Planets[i][3] = Planets[i][3] + Planets[i][4]; -- On incrémente l'angle avec la vitesse.
      love.graphics.draw(Planets[i][1], planetX, planetY)
   end
end

--[[
Génère un tableau contenant les coordonnées (x,y) des étoile à dessiner.
--]]
function generateStarField()
   Stars = {}
   max_stars = 100
   -- Générer les coordonnées aléatoirement des étoiles.
   for i=1, max_stars do
      Stars[i] = {
         math.random(5, love.graphics.getWidth()-5), 
         math.random(5, love.graphics.getHeight()-5)
      }
   end
end

