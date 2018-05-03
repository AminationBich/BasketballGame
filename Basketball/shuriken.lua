function initShuriken()
  
  shuriken = {}
  shuriken.texture = love.graphics.newImage("Textures/shuriken.png")
  
end

function createShuriken(p_x,p_y,p_velx,p_vely)
  
  local l_shuriken = {
    x = p_x,
    y = p_y,
    width = 20,
    height = 20,
    velx = p_velx,
    vely = p_vely,
  }
  
  table.insert(
    shuriken,
    l_shuriken
  )
  
end

function createStandardShuriken()
  
  createShuriken(math.random(0,1200),math.random(0,500),100,100)
  createShuriken(math.random(0,1200),math.random(0,500),200,200)
  createShuriken(math.random(0,1200),math.random(0,500),150,150)
  createShuriken(math.random(0,1200),math.random(0,500),150,150)
  createShuriken(math.random(0,1200),math.random(0,500),250,250)
  createShuriken(math.random(0,1200),math.random(0,500),250,150)
  createShuriken(math.random(0,1200),math.random(0,500),250,150)
  
end

function shurikenUpdate(dt)
  
  for i,v in ipairs(shuriken) do
    if v.x < 0 then
      v.x = 0
      v.velx = - v.velx
    end
    
    if v.x > 1200 - v.width then
      v.x = 1200 - v.width
      v.velx = - v.velx
    end
    
    if v.y < 0 then
      v.y = 0
      v.vely = - v.vely
    end
    
    if (v.y > player.jumpStartHeight - v.height) and
    (v.vely > 0) then
      v.y = player.jumpStartHeight - v.height
      v.vely = - v.vely
    end
    
    v.x = v.x + v.velx * dt
    v.y = v.y + v.vely * dt
    
  end
  
end

function drawShuriken()
  
  for i,v in ipairs(shuriken) do
    love.graphics.draw(shuriken.texture,v.x,v.y)
  end
  
end