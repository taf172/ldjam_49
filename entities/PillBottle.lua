local secsi = require 'secsi'
local Pill = require 'entities.Pill'

local PillBottle = secsi.entity{
    icon = love.graphics.newImage('assets/pillbottle.png'),
    image = 'rect',
    render = true,
    layer = 2,
}

local ww, wh = love.graphics.getDimensions()
function PillBottle:init()
    self.iconHeight = 150
    self.iconWidth = self.icon:getWidth()*(self.iconHeight/self.icon:getHeight())
    self.rotation = math.rad(-15)
    self.tweens = {}
    self.items = {
        Pill('b', 'o'),
        Pill('r', 'g'),
        Pill('y', 'p'),
        
        Pill('b', 'p'),
        Pill('r', 'o'),
        Pill('y', 'g'),
        
        Pill('b', 'g'),
        Pill('r', 'p'),
        Pill('y', 'o'),
    }
    self.dispenser = true
    self.dispenseHorizontal = true
    self.itemGap = self.items[1].width
    
    self.height = self.iconHeight
    self.width = #self.items*(self.itemGap) + self.iconWidth
    self.iconX = -self.width/2 + self.iconWidth/2
    self.iconY = 0
    self.iconRotation = math.rad(-15)
    
    self.x = ww + self.width/2 - self.iconWidth
    self.y = self.iconHeight/2 + 15
    self.hover = true
    self.hoverTo = { x = self.x - self.width + self.iconWidth, y = self.y}
    self.hoverOff= { x = self.x, y = self.y}

    self.hoverToSound = love.audio.newSource('assets/sounds/pillopen.wav', 'static')
    self.hoverOffSound = love.audio.newSource('assets/sounds/pillclose.wav', 'static')
    --self.icon = false
    
    self.alpha = 0.75
    self.color = {218/255, 103/255, 0}
end

return PillBottle