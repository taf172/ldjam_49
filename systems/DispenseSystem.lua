local secsi = require 'secsi'

local DisepnseSystem = secsi.system{'items', 'dispenser'}

function DisepnseSystem.update(e)

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