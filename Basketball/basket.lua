function initBasket()

	basket = {}
  basket.texture = love.graphics.newImage("Textures/basket.png")
	basket.x = 500
	basket.y = 500
	basket.width = 80
	basket.height = 60
	basket.speedx = 0
	basket.speedy = 0
	basket.directionTimer = 0
	
end

function drawBasket()

	love.graphics.draw(basket.texture,basket.x,basket.y)

end

function randomBasketDirection()

	basket.speedx = love.math.random(250)
	basket.speedy = 250 - basket.speedx
	if love.math.random(2) == 1 then
		basket.speedx = - basket.speedx
	end
	
	if love.math.random(2) == 1 then
		basket.speedy = - basket.speedy
	end
	
end


function basketUpdate(dt)

	basket.directionTimer = basket.directionTimer - dt

	if basket.directionTimer < 0 then
		randomBasketDirection()
		basket.directionTimer = 1.2
	end
	basket.x = basket.x + basket.speedx * dt
	basket.y = basket.y + basket.speedy * dt
	basketCollisionDetection()

end

function basketCollisionDetection()

	if basket.x < 0 then
		basket.x = 0
		basket.speedx = - basket.speedx
	end
	
	if basket.y < 0 then
		basket.y = 0
		basket.speedy = - basket.speedy
	end

	if basket.x > 1200 - basket.width then
		basket.x = 1200 - basket.width
		basket.speedx = - basket.speedx
	end
	
	if basket.y > 600 - basket.height then
		basket.y = 600 - basket.height
		basket.speedy = - basket.speedy
	end
	
end