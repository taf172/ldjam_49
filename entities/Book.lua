local secsi = require 'secsi'

local Book = secsi.entity{
    openImage = love.graphics.newImage('assets/book.png'),
    closedImage = love.graphics.newImage('assets/closedbook.png'),
    render = true,
    layer = 3,
    pressable = true,
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

    --[[
    self.open = true
    self.swap = true
    --]]

    local p1 = {
        name = 'Tutorialitis',
        symptoms = 'Cough, Fever, Eye Boogies',
        step1 = 'Do the first thing',
        step2 = 'Then you have to do the second thing',
        step3 = 'Don\'t forget the last thing!',
    }

    local p2 = {
        name = 'Exampleitis',
        symptoms = 'These, are, other, symptoms',
        step1 = 'This first step is different then the other',
        step2 = 'It has extra text so i can see how the looks for this',
        step3 = 'Also thats it',
    }

    local p3 = {
        name = 'Omg its a thing',
        symptoms = 'asdasd, asd, erh dgasd',
        step1 = 'asdfas dfasdf asdfasdfas dfasdf',
        step2 = 'ddfsdfs fdsfsd fsdfsdfs dfsdfs',
        step3 = 'ddddd dddddddd dddd',
    }

    local p4 = {
        name = 'More tests',
        symptoms = 'These, are, different, symptoms, from, the, last, one',
        step1 = 'This game is an absolute trainwreck',
        step2 = 'Here is some random text',
        step3 = 'Please end me',
    }

    self.pages = {p1, p2, p3, p4}
    self.onPage = 1
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