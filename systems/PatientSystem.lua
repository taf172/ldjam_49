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

local happySounds = {
    love.audio.newSource('assets/sounds/happy1.wav', 'static'),
    love.audio.newSource('assets/sounds/happy3.wav', 'static'),
    love.audio.newSource('assets/sounds/happy4.wav', 'static'),
    love.audio.newSource('assets/sounds/happy5.wav', 'static'),
    love.audio.newSource('assets/sounds/happy6.wav', 'static'),
    love.audio.newSource('assets/sounds/happy7.wav', 'static'),
}
local lastSound = 1
function PatientSystem.update(e, dt)

    if e.eatPill then
        local p = e.eatPill
        if e.allergies[p.color1] or e.allergies[p.color2] then
            e.heartrate = e.heartrate + 10
        end
        table.insert(e.pillsTaken, p)
        e.eatPill = nil
    end

    if cureButton.pressed and not e.cured then
        e.cured = true
    end

    if e.cured and not e.awake then
        e.blinking = true
        e.awake = true
    end

    if e.awake and not (e.blinking or e.leaving) then
        local r = math.random(1,#happySounds)
        while r == lastSound do
            r = math.random(1,#happySounds)
        end
        happySounds[r]:play()

        local emitter = Emitter()
        emitter.x = e.x + 32
        emitter.y = e.y - e.height/2 + 64
        emitter.lifetime = 0.75
        emitter.particle = 'heart'
        emitter.rate = emitter.lifetime/math.random(2, 3)
        e.happyDance = true
        e.leaving = true
    end

    if e.leaving and not (e.happyDance or e.walkAway) then
        e.walkAway = true
    end

    if e.x <= -e.width/2 then
        e.gone = true
        e:remove()
    end

end