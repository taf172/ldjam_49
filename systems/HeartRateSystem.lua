local secsi = require 'secsi'
local Game = require 'entities.Game'

local beep = love.audio.newSource('assets/sounds/beep.wav', 'static')
beep:setVolume(0.25)

local flatline = love.audio.newSource('assets/sounds/flatline.wav', 'static')
flatline:setLooping(true)
flatline:setVolume(0.2)

local pulseTime = 1
local timer = 0
local increaseRate = 2
local HeartRateSystem = secsi.system{'heartrate', 'maxHeartRate'}
function HeartRateSystem.update(e, dt)
    if not e.dead then
        flatline:stop()
        timer = timer + dt
        if timer > pulseTime then
            beep:play()
            timer = 0
            pulseTime = 60/e.heartrate
        end
    else
        flatline:play()
    end
    if not (e.cured or e.dead or e.tutorial) then
        e.heartrate = e.heartrate + increaseRate * dt
    end
    if e.heartrate > e.maxHeartRate then
        e.dead = true
    end
end