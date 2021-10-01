local secsi = require 'libs.secsi'

local CameraTrackingSystem = secsi.system{'tracking'}

local wh = love.graphics.getHeight()
local maxDist = 32
function CameraTrackingSystem.update(e, dt)
    local dist = math.sqrt((e.x - e.tracking.x)^2 + (e.y - e.tracking.y)^2)
    local smoothRate = dist/maxDist
    e.x = e.x + (e.tracking.x - e.x)*smoothRate*dt
    e.y = e.y + (e.tracking.y - (wh/2 - wh/3) - e.y)*smoothRate*dt
end
