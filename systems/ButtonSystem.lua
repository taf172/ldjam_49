local secsi = require 'secsi'
local Game = require 'entities.game'

local ButtonSystem = secsi.system{
    'pressable',
    'x', 'y', 'width', 'height',
}

local mouse = secsi.add{
    isMouse=true,
    held = false
}

function ButtonSystem.update(e)
    e.pressed = false
    e.pressedOff = false
    local mx, my = love.mouse.getPosition()
    local md = love.mouse.isDown(1)
    if mx > e.x - e.width/2 and mx < e.x + e.width/2
    and my > e.y - e.height/2 and my < e.y + e.height/2 then
        if md and not mouse.held then
            e.pressed = true
        end
    elseif md and not mouse.held then
        e.pressedOff = true
    end
end

local DragSystem = secsi.system{'draggable'}
function DragSystem.update(e)
    local mx, my = love.mouse.getPosition()

    if e.pressed then
        e.dragging = true
    end

    if e.dragging then
        e.x = Game.arm.x
        e.y = Game.arm.y - Game.arm.height/2
    end

    if e.dragging and not love.mouse.isDown(1) then
        e.dragging = false
    end
end


local MouseSystem = secsi.system{'isMouse'}
function MouseSystem.update(e)
    e.held = love.mouse.isDown(1)
end