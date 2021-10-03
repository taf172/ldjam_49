local secsi = require 'secsi'
local Button = require 'entities.button'
local Emitter = require 'entities.emitter'

local ww, wh = love.graphics.getDimensions()
local cureButton = Button()
cureButton.text = 'cure'
cureButton.width = 64*3
cureButton.height = cureButton.width/3
cureButton.x = ww - cureButton.width/2 - 25
cureButton.y = wh/2 - cureButton.height/2

local PatientSystem = secsi.system{'isPatient'}

function PatientSystem.update(e, dt)

    if cureButton.pressed and not e.cured then
        e.cured = true
    end

    if e.cured then
        e.wakeUp = true
        e.blinking = true
    end

    if e.wakeUp and not e.blinking then
        local emitter = Emitter()
        emitter.x = e.x + 32
        emitter.y = e.y - e.height/2 + 64
        emitter.lifetime = 1
        emitter.particle = 'heart'
        emitter.rate = emitter.lifetime/math.random(3, 5)
        e.happyDance = true
        e.wakeUp = false
        e.leave = true
    end

    if e.leave and not e.happyDance then
        e.walkAway = true
        e.leave = false
    end

    if e.x <= -e.width/2 then
        e.gone = true
    end
end