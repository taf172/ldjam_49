local secsi = require 'secsi'
local Heart = require 'entities.Heart'

local LifetimeSystem = secsi.system{'timer', 'lifetime'}
function LifetimeSystem.update(e, dt)
    if e.timer >= e.lifetime then
        secsi.remove(e)
    else
        e.timer = e.timer + dt
    end
end

local ParticleSystem = secsi.system{
    'x', 'y', 'particle', 'rate'
}

function ParticleSystem.update(e, dt)
    if not e.ratetimer then e.ratetimer = 0 end
    if e.particle == 'heart' then
        e.ratetimer = e.ratetimer + dt
        if e.ratetimer >= e.rate then
            local p = Heart()
            local r = 64
            local theta = math.random() * 2 * math.pi
            p.x = math.floor(e.x + r * math.cos(theta))
            p.y = math.floor(e.y + r * math.sin(theta))
            e.ratetimer = 0
        end
    end
end
