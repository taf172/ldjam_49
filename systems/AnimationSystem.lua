local secsi = require 'secsi'
local Emitter = require 'entities.Emitter'

local AnimationSystem = secsi.system{
    all = {'tweens'},
    any = {
        'float', 'blinking', 'leaving',
        'bounce', 'hop', 'happyDance',
        'walkAway', 'fling', 'shake'
    }
}

local ww, wh = love.graphics.getDimensions()
function AnimationSystem.update(e, dt)
    if e.shake then
        if not e.shakeTimer then
            e.shakeTimer = 0
            e.shakeStartX = e.x
            e.shakeStartY = e.y
        elseif e.shakeTimer > 0.5 then
            e.x = e.shakeStartX
            e.y = e.shakeStartY
            e.shakeTimer = nil
            e.shakeStartX = nil
            e.shakeStartY = nil
            e.shake = false
        else
            e.shakeTimer = e.shakeTimer + dt
            e.x = e.shakeStartX + math.random(-5, 5)
            e.y = e.shakeStartY + math.random(-5, 5)
        end
    end

    if e.float then
        e.tweens.y = {-e.height/2, e.lifetime, 'linear'}
        e.float = false
    end

    if e.fade then
        e.tweens.alpha = {0, e.lifetime, 'linear'}
        e.fade = false
    end

    if e.blinking and not e.blinkTimer then
        e.eyesClosed = false
        e.blinking = true
        e.blinkTimer = 0
        e.blinkCount = 0
    elseif e.blinking then
        local t = 0.05
        local n = 3
        e.blinkTimer = e.blinkTimer + dt
        if not e.eyesClosed and e.blinkTimer >= t*5 then
            e.blinkTimer = 0
            e.eyesClosed = true
        elseif e.eyesClosed and e.blinkTimer >= t then
            e.blinkTimer = 0
            e.eyesClosed = false
            e.blinkCount = e.blinkCount + 1
        end
        if e.blinkCount >= n then
            e.blinking = false
            e.blinkTimer = false
        end
    end

    if e.happyDance then
        ---[[
        local mh = 3
        if e.numHops and e.numHops >= mh  and not e.hop then
            e.happyDance = false
            e.numHops = nil
        elseif e.numHops and not e.hop then
            e.hop = true
            e.numHops = e.numHops + 1
        elseif not e.numHops then
            local emitter = Emitter()
            emitter.x = e.x + 32
            emitter.y = e.y - e.height/2 + 64
            emitter.lifetime = 1
            emitter.particle = 'heart'
            emitter.rate = 0.5
            e.numHops = 0
        end
        --]]
    end

    if e.hop then
        local hh = 64
        local ht = 0.125

        if e.hopStartHeight and e.y == e.hopStartHeight then
            e.hop = false
            e.hopStartHeight = nil
        elseif not e.hopStartHeight then
            e.hopStartHeight = e.y
            e.tweens.y = {e.y - hh, ht, 'quadOut'}
            e.tweens.y.onComplete = {e.y, ht, 'quadIn'}
        end
    end

    if e.walkAway then
        local stepTime = 0.125
        if not e.walkAwayTimer then
            e.tweens.x = {-e.width/2, 1, 'linear'}
            e.walkAwayTimer = 0
            e.step = 10
        elseif e.walkAwayTimer >= stepTime then
            e.walkAwayTimer = 0
            e.step = e.step*-1
            e.rotation = math.rad(e.step)
        elseif e.walkAwayTimer then
            e.walkAwayTimer = e.walkAwayTimer + dt
        end

        -- e.walkAway = false
        -- e.flip = not e.flip
    end

    if e.fling then
        e.tweens.x = {-e.width/2, 3, 'quadIn'}
        e.fling = false
    end

    --[[
    if e.sway then
        if not e.tweens.x then
            e.tweens.x = {e.x + e.sway, e.lifetime/5, 'quadOut'}
            e.tweens.x.onComplete = {e.x - e.sway, e.lifetime/5, 'quadOut'}
        end
    end
    --]]
end