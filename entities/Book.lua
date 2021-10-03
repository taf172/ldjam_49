local secsi = require 'secsi'

local Book = secsi.entity{
    openImage = love.graphics.newImage('assets/book.png'),
    closedImage = love.graphics.newImage('assets/closedbook.png'),
    render = true,
    layer = 4,
    pressable = true
}

local ww, wh = love.graphics.getDimensions()
function Book:init(x, y)
    self.image = self.closedImage
    self.height = 325
    self.width = self.image:getWidth()*(self.height/self.image:getHeight())
    self.x = ww - 25 - self.width/2
    self.y = wh + self.height/8 + 30

    self.hover = true
    self.hoverTo = { x = self.x, y = wh - self.height/2}
    self.hoverOff= { x = self.x, y = self.y}

    self.open = false

    --[[
    self.text = "this is a clip board!this is" ..
    "this is a clip board!this is" .. "this is a clip board!this is" ..
    "this is a clip board!this is" .. "this is a clip board!this is" ..
    "this is a clip board!this is" .. "this is a clip board!this is"
    self.textColor = {0.1, 0.1, 0.1}
    self.textWidth =  self.width*3/4
    self.textY = self.height*0.39
    self.textX = self.width*1/8
    --]]

    self.tweens = {}
end

return Book