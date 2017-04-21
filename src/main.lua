local map, player, tileSize, noiseModifier = {}, {x=0,y=0}, 20, 50
local width, height

local graphics = love.graphics
local math = love.math
local keyboard = love.keyboard

function love.load()
  width = graphics.getWidth()/tileSize
  height = graphics.getHeight()/tileSize
end

local time, rate = 0, 1/12
function love.update(dt)
  time = time + dt
  if time >= rate then
    if keyboard.isDown("w") then
      player.y = player.y - 1
      local noise = math.noise(player.x/noiseModifier, player.y/noiseModifier)
      if noise > 0.9 then
        player.y = player.y + 1
      end
    end
    if keyboard.isDown("s") then
      player.y = player.y + 1
      local noise = math.noise(player.x/noiseModifier, player.y/noiseModifier)
      if noise > 0.9 then
        player.y = player.y - 1
      end
    end
    if keyboard.isDown("a") then
      player.x = player.x - 1
      local noise = math.noise(player.x/noiseModifier, player.y/noiseModifier)
      if noise > 0.9 then
        player.x = player.x + 1
      end
    end
    if keyboard.isDown("d") then
      player.x = player.x + 1
      local noise = math.noise(player.x/noiseModifier, player.y/noiseModifier)
      if noise > 0.9 then
        player.x = player.x - 1
      end
    end
    time = time - rate
  end
end

function love.draw()
  for x = 0, width do
    for y = 0, height do
      local noise = math.noise((player.x - width/2 + x)/noiseModifier, (player.y - height/2 + y)/noiseModifier)
      if noise > 0.9 then
        graphics.setColor(0, 0, noise * 300, 255)
      elseif noise > 0.2 then
        noise = 0.982 - noise/1.2
        graphics.setColor(0, noise * 255, 0, 255)
      else
        noise = noise + 0.3
        graphics.setColor(noise * 425, noise * 260, noise * 78, 255)
      end
      graphics.rectangle("fill", x * tileSize - tileSize/2, y * tileSize - tileSize/2, tileSize, tileSize)
    end
  end
  graphics.setColor(255, 0, 0, 255)
  graphics.circle("fill", width/2 * tileSize, height/2 * tileSize, 2)
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end
