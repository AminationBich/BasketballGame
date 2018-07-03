function initShuriken()
  
  shuriken = {}
  shuriken.width = 20
  shuriken.height = 20
  shuriken.texture = love.graphics.newImage("Textures/shuriken.png")
  
end

function createShuriken(p_x,p_y,p_velx,p_vely)
  
  local l_shuriken = {
    x = p_x,
    y = p_y,
    velx = p_velx,
    vely = p_vely,
    rotation = 0,
    rotationSpeed = (p_velx + p_vely) / 50000
  }
  
  table.insert(
    shuriken,
    l_shuriken
  )
  
end

function createStandardShuriken()
  
  createShuriken(math.random(0,1200),math.random(0,500),200,200)
  createShuriken(math.random(0,1200),math.random(0,500),350,150)
  createShuriken(math.random(0,1200),math.random(0,500),250,250)
  createShuriken(math.random(0,1200),math.random(0,500),250,150)
  createShuriken(math.random(0,1200),math.random(0,500),250,150)
  createShuriken(math.random(0,1200),math.random(0,500),200,350)
  
end

function updateShuriken(dt)
  
  for i,v in ipairs(shuriken) do
    if v.x < 0 then
      v.x = 0
      v.velx = - v.velx
    end
    
    if v.x > 1200 - shuriken.width then
      v.x = 1200 - shuriken.width
      v.velx = - v.velx
    end
    
    if v.y < 0 then
      v.y = 0
      v.vely = - v.vely
    end
    
    if (v.y > player.jumpStartHeight - shuriken.height) and
    (v.vely > 0) then
      v.y = player.jumpStartHeight - shuriken.height
      v.vely = - v.vely
    end
    
    shurikenHitPlayer(v.x,v.y)
    
    v.x = v.x + v.velx * dt
    v.y = v.y + v.vely * dt
    
    v.rotation = v.rotation + v.rotationSpeed
    if v.rotation >= 2 * math.pi then v.rotation = v.rotation - 2 * math.pi end
    
  end
  
end

function shurikenHitPlayer(p_x,p_y)
  
  if (p_x + shuriken.width > player.x) and
  (p_x < player.x + player.width) and
  (p_y + shuriken.height > player.y) and
  (p_y < player.y + player.height) then
    if not player.isHit then
      hitPlayer()
    end
  end
  
end

function drawShuriken()
  
  for i,v in ipairs(shuriken) do
    love.graphics.draw(shuriken.texture,v.x + shuriken.width / 2,v.y + shuriken.height / 2,v.rotation,1,1,shuriken.width / 2,shuriken.height / 2)
  end
  
end