local secsi = require 'secsi'

local Clipboard = secsi.entity{
    image = love.graphics.newImage('assets/clipboard.png'),
    render = true,
    layer = 2,
    isClipboard = true
}

local ww, wh = love.graphics.getDimensions()
function Clipboard:init(x, y)
    self.height = 325
    self.width = self.image:getWidth()*(self.height/self.image:getHeight())
    self.x = 25 + self.width/2
    self.y = wh + self.height/8
    self.scale = 1/2

    self.textColor = {0.1, 0.1, 0.1}
    self.textWidth =  self.width*3/4 + 25
    self.textY = self.height*0.39
    self.textX = self.width*1/8

    self.hover = true
    self.hoverTo = { x = self.x, y = wh - self.height/2}
    self.hoverOff= { x = self.x, y = self.y}

    self.tweens = {}

    self.name = "Mr. TestCat"
    self.symptoms = "Fever, Cough, Eye Boogies"
    self.allergies = "Blue medicine"
    self.notes = "Likes long walks on the beach"

    local month = math.random(1,12)
    local day = math.random(1, 31)
    local year = math.random(1960, 2010)
    local sex = 'M'
    if math.random() > 0.5 then
        sex = 'F'
    end
    self.sex = sex
    self.birthday = month..'/'..day..'/'..year

end

return Clipboard