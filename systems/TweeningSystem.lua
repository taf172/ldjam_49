local secsi = require 'secsi'

local TweenManagementSystem = secsi.system{'tweens'}

-- tweens.component = { target, duration, type }

local function initTween(e, component, tween)
    tween.targetValue = tween[1]
    tween.duration = tween[2]
    tween.type = tween[3]
    tween.entity = e
    tween.component = component
    tween.startValue = e[component]
    tween.change = tween.targetValue - e[component]
    tween.timer = 0
    tween.active = true
end

function TweenManagementSystem.update(e, dt)
    for component in pairs(e.tweens) do
        local tween = e.tweens[component]
        if not tween.active then
            initTween(e, component, tween)
        end

        if tween.timer > tween.duration then
            e[component] = tween.targetValue
            if tween.onComplete then
                e.tweens[component] = tween.onComplete
            else
                e.tweens[component] = nil
            end
            return
        end 
        
        if tween.wait then
            tween.wait = tween.wait - dt
            if tween.wait <= 0 then tween.wait = nil end
        else
            tween.timer = tween.timer + dt
        end

        local type = tween.type
        local t = tween.timer
        local c = tween.change
        local b = tween.startValue
        local d = tween.duration
        local i = 0

        if type == 'linear' then
            i = c*t/d + b
        elseif type == 'quadIn' then
            t = t/d
            i = c*t*t + b
        elseif type == 'quadOut' then
            t = t/d
            i = -c * t * (t-2) + b
        elseif type == 'cubicOut' then
            t = t/d
            t = t-1
            i = c*(t*t*t+1)+b
        end

        if not tween.wait then
            e[component] = i
        end
        --[[
        --]]
    end
end