local secsi = require 'secsi'

local Monitor = secsi.entity{
    image = love.graphics.newImage('assets/monitor.png'),
    render = true,
    layer = 2
}

local ww, wh = love.graphics.getDimensions()
function Monitor:init()
    self.height = 250
    self.width = self.image:getWidth()*(self.height/self.image:getHeight())
    self.x = self.width/2
    self.y = self.height/2
    self.flip = true
    self.rotation = math.rad(15)
    self.text = "this is a monitor!!!" .. "this is a monitor!!!" ..
    "this is a monitor!!!" .. "this is a monitor!!!" ..
    "this is a monitor!!!" .. "this is a monitor!!!" ..
    "this is a monitor!!!" .. "this is a monitor!!!"

    self.textColor = {0, 1, 0.1}
    self.textWidth =  self.width*0.59
    self.textX = self.width*0.31
    self.textY = self.height*0.19

end

return Monitor