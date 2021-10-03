local secsi = require 'secsi'

local Pill = secsi.entity{
    render = true,
    hudItem = true,
    pressable = true,
    draggable = true,
    onCamera = true,
    image = 'rect',
}

function Pill:init()
    local ww, wh = love.graphics.getDimensions()
    self.layer = 3
    self.isDown = false
    self.x = ww - 100
    self.y = wh/3
    self.width = 200
    self.height = 100
    self.color = {0.9, 0.9, 0.9}
    self.text = 'Pill'
    self.textColor = {0.2, 0.9, 0.2}
    self.textCenter = true
    self.draggable = true
end

return Pill