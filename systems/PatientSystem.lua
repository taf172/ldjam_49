local secsi = require 'secsi'
local Button = require 'entities.Button'
local Emitter = require 'entities.Emitter'
local Game = require 'entities.Game'

local ww, wh = love.graphics.getDimensions()
local cureButton = Button()
cureButton.text = 'cure'
cureButton.width = 64*3
cureButton.height = cureButton.width/3
cureButton.x = ww - cureButton.width/2 - 25
cureButton.y = wh/2 - cureButton.height/2
cureButton.render = false

local throwUpSound = love.audio.newSource('assets/sounds/bleh.wav','static')
throwUpSound:setVolume(0.25)

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
    if not e.tutorial then
        cureButton.render = true
    end
    if e.eatPill then
        local p = e.eatPill
        if e.allergies[p.color1] or e.allergies[p.color2] then
            throwUpSound:play()
            Game.monitor.shake = true
            e.heartrate = e.heartrate + 20
            e.eatPill.render = true
            e.eatPill.tweens.x = {e.x + e.width/2 + math.random(25, 100), 0.5, 'quadOut'}
            e.eatPill.tweens.y = {e.y - math.random(20, e.height/2 - 25), 0.5, 'quadOut'}
        else
            table.insert(e.pillsTaken, p)
        end
        e.eatPill = nil
    end

    if cureButton.pressed and not (e.cured or e.tutorial) then
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

    if e.dead and not e.flung then
        e.flung = true
        e.fling = true
    end

    if e.x <= -e.width/2 then
        e.gone = true
        e:remove()
    end

end