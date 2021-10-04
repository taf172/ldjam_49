local secsi = require 'secsi'

local Disease = secsi.entity{
    isDisease = true
}

function Disease:init()

    self.phase = 1
    self.pillsTaken = {}

    -- Take two pills
    -- If they had a matching color give one without that color, otherise give Purple
    -- 
end

return Disease