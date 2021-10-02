local secsi = require 'secsi'
local Button = require 'entities.button'
local Heart = require 'entities.heart'

local ww, wh = love.graphics.getDimensions()
local cure = Button()
cure.text = 'CURE'
cure.width = 64*3
cure.height = cure.width/3
cure.x = ww - cure.width/2 - 25
cure.y = wh/2 - cure.height/2

local PatientSystem = secsi.system{'isPatient'}

function PatientSystem.update(e)

    if cure.pressed then
        e.cured = true
    end
    
    if e.cured then
        e.cured = false
        e.eyelids = false
        e.happy = true
        local heart = Heart()
        heart.x = e.x + 32
        heart.y = e.y - e.height/2 + 32
    end
end