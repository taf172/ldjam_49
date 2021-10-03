local secsi = require 'secsi'

local AnimationSystem = secsi.system{
    all = {'tweens'},
    any = {
        'float', 'blinking', 'leaving',
        'bounce', 'hop', 'happyDance',
        'walkAway'
    }
}

local ww, wh = love.graphics.getDimensions()
function AnimationSystem.update(e, dt)
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
        e.tweens.x = {-e.width/2, 1, 'linear'}
        e.walkAway = false
        -- e.flip = not e.flip
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