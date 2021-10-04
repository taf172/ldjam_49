local secsi = require 'secsi'

local Book = secsi.entity{
    openImage = love.graphics.newImage('assets/book.png'),
    closedImage = love.graphics.newImage('assets/closedbook.png'),
    render = true,
    layer = 4,
    pressable = true,
}

local diseases = {
    'Delirious Rash',
    'Brain Acne',
    'Stinging Tetanus',
    'Explosive Anxiety',
    'Incurable Sneeze',
    'Rickety Eye',
    'Orange Leprosy',
    'Incurable Nose',
    'Pig Spasms',
    'Dreaming Feet',
}

local symtpoms = {
    'Restlessness',
    'Scoliosis',
    'Coughing',
    'Sneezing',
    'Runny Nose',
    'Itchy Fur',
    'Tail Curl',
    'Quiet Meow',
    'Enlarged Knees',
    'Loss of Taste',
    'Male-Pattern Whisker Loss',
    'Uncontrollable Running',
    'Paw Rash',
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
        step1 = 'Give patient two pills',
        step2 = 'If the first two pills had a matching color give another pill'..
        ' without that color, else give patient a purple pill',
        step3 = 'Administer three pats to the belly',
    }

    local p2 = {
        name = 'Overscope Syndrom',
        symptoms = 'Lack of sleep, frantic coding',
        step1 = 'I wasn\'t able to finish in time',
        step2 = 'The idea was to have more diseases with complex procedures'..
        ' as well as more items to interact with',
        step3 = 'Hope you enjoyed it anyways!',
    }

    self.pages = {p1, p2}
    self.onPage = 1

    for i=1, #diseases do
        local r1 = math.random(1, #symtpoms)
        local r2 = math.random(1, #symtpoms)
        while r2 == r1 do
            r2 = math.random(1, #symtpoms)
        end

        local page = {
            name = diseases[i],
            symptoms = symtpoms[r1]..', '..symtpoms[r2],
            step1 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ullamcorper luctus malesuada.',
            step2 = 'Sed pharetra ac tortor in bibendum.',
            step3 = 'Vestibulum cursus elit ac tellus maximus, et suscipit massa eleifend.'
        }
        table.insert(self.pages, page)
    end
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