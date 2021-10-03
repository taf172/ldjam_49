local secsi = require 'secsi'

local Emitter = secsi.entity{}

function Emitter:init()
    self.timer = 0
    self.ratetimer = 0
end

return Emitter