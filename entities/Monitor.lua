local secsi = require 'secsi'
local anim8 = require 'anim8'

local Monitor = secsi.entity{
    image = love.graphics.newImage('assets/monitor.png'),
    render = true,
    layer = 1,
    isMonitor = true
}

local ww, wh = love.graphics.getDimensions()
function Monitor:init()
    self.height = 250
    self.width = self.image:getWidth()*(self.height/self.image:getHeight())
    self.x = self.width/2
    self.y = self.height/2
    self.flip = true
    self.rotation = 0
    --self.text = "this is a monitor!!!" .. "this is a monitor!!!"

    self.textColor = {0, 1, 0.1}
    self.textWidth =  self.width*0.59
    self.textX = self.width*0.31
    self.textY = self.height*0.19

     self.blip = love.graphics.newImage('assets/blip.png')
    local blipg = anim8.newGrid(610, 400, self.blip:getWidth(), self.blip:getHeight())
    local heartRate = 75
    local blipTime = 1
    local blipdur = blipTime/(14*5)
    self.animation = anim8.newAnimation(blipg('1-5', '1-14'), blipdur)

end

return Monitor