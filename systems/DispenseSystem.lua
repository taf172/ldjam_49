local secsi = require 'secsi'

local DisepnseSystem = secsi.system{'items', 'dispenser'}

function DisepnseSystem.update(e)
    if e.reset then
        for i=1, #e.items do
            e.items[i].edible = true
            e.items[i].render = true
            e.items[i].outOfDispenser = false
            e.items[i].layer = e.layer + 1
        end
        e.reset = false
    end
    if e.dispenseHorizontal then
        for i=1, #e.items do
            local item = e.items[i]
            if not item.dragging and not item.outOfDispenser then
                item.x = e.iconWidth + item.width/2 + e.x - e.width/2 + e.itemGap*(i-1)
                item.y = e.y
            else
                item.outOfDispenser = true
            end
        end
    end

end