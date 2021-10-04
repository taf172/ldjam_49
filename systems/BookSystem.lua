local secsi = require 'secsi'

local BookSystem = secsi.system{'openImage', 'closedImage'}

local ww, wh = love.graphics.getDimensions()
local closeSound = love.audio.newSource('assets/sounds/bookclose.wav', 'static')
closeSound:setVolume(0.25)
local openSound = love.audio.newSource('assets/sounds/bookopen.wav', 'static')
openSound:setVolume(0.25)
local flipSound = love.audio.newSource('assets/sounds/pageflip.wav', 'static')
flipSound:setVolume(0.5)

function BookSystem.update(e)
    
    if  not e.open and e.swap then
        e.image = e.closedImage
        e.height = 325
        e.width = e.image:getWidth()*(e.height/e.image:getHeight())
        e.x = ww - 25 - e.width/2
        e.y = wh + e.height/8 + 30
        
        e.hover = true
        e.swap = false
    end
    
    if e.open and e.swap then
        e.image = e.openImage
        e.height = wh*0.8
        e.width = e.image:getWidth()*(e.height/e.image:getHeight())
        e.x = ww/2
        e.y = wh/2
        
        e.tweens = {}
        e.hover = false
        e.swap = false
    end
    
    if e.open and e.pressed then
        local mx, my = love.mouse.getPosition()
  
        if mx > e.x and e.onPage + 2 <= #e.pages - 1 then
            e.onPage = e.onPage + 2
            flipSound:stop()
            flipSound:play()
        end
        if mx <= e.x and e.onPage > 1 then
            e.onPage = e.onPage - 2
            flipSound:stop()
            flipSound:play()
        end
    end
    
    if not e.open and e.pressed then
        openSound:play()
        e.open = true
        e.swap = true
    end
    if e.open and e.pressedOff then
        closeSound:play()
        e.open = false
        e.swap = true
    end
end