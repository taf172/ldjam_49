local secsi = require 'secsi'


local Pill = secsi.entity{
    render = true,
    pressable = true,
    draggable = true,
    edible = true
}

function Pill:init(c1, c2)
    local ww, wh = love.graphics.getDimensions()
    self.layer = 3
    self.x = ww - 100
    self.y = wh/3

    self.image = love.graphics.newImage('assets/pills/'..c1..c2..'pill.png')
    self.height = 50
    self.width = self.image:getWidth()*(self.height/self.image:getHeight())

    self.tweens = {}
    ---[[
        if c1 == 'b' then
            self.color1 = 'blue'
        elseif c1 == 'r' then
            self.color1 = 'red'
        elseif c1 == 'y' then
            self.color1 = 'yellow'
        end

        if c2 == 'o' then
            self.color2 = 'orange'
        elseif c2 == 'g' then
            self.color2 = 'green'
        elseif c2 == 'p' then
            self.color2 = 'purple'
        end
        --]]
end

return Pill