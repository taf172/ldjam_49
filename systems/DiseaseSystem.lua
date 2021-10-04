local secsi = require 'secsi'
local Game = require 'entities.game'

local DiseaseSystem = secsi.system{'isPatient'}

local function hasColor(p, c)
    return p.color1 == c or p.color2 == c
end

local function shareColor(p1, p2)
    if p1.color1 == p2.color1 then
        return p1.color1
    elseif p1.color2 == p2.color2 then
        return p1.color2
    end
    return false
end

function DiseaseSystem.update(e)
    if e.disease == 'Tutorialitis' then
        -- Take two pills
        if e.phase == 1 then
            if #e.pillsTaken == 2 then
                e.phase = 2
            end
        end

        if e.phase == 2 then
            if not e.pillsTaken[3] then return end
            local p1 = e.pillsTaken[1]
            local p2 = e.pillsTaken[2]
            local p3 = e.pillsTaken[#e.pillsTaken]

            -- If two had the same color take another without the matching color.
            if shareColor(p1, p2)
            and not hasColor(p3, shareColor(p1, p2)) then
                e.phase = 3
            end
            -- Else take a purple pill.
            if not shareColor(p1, p2) and hasColor(p3, 'purple') then
                e.phase = 3
            end
        end
        if e.phase == 3 then
            e.cured = true
        end
    end

end


