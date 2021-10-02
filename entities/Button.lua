local secsi = require 'secsi'

local Button = secsi.entity{
    render = true,
    hudItem = true,
    pressable = true,
    onCamera = true,
    image = 'rect'
}

function Button:init()
    local ww, wh = love.graphics.getDimensions()
    self.layer = 1
    self.isDown = false
    self.x = ww/2
    self.y = wh/2
    self.width = ww/2
    self.height = wh/10
    self.color = {0.9, 0.9, 0.9}
    self.text = 'BUTTON'
    self.textColor = {0.2, 0.9, 0.2}
    self.textCenter = true
end

return Button