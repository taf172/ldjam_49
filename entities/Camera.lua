local secsi = require 'libs.secsi'

local Camera = secsi.entity{}

function Camera:init()
    self.x = love.graphics.getWidth()/2
    self.y = love.graphics.getHeight()/2
end

return Camera