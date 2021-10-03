local secsi = require 'secsi'

local RenderSystem = secsi.system{ 'x', 'y', 'image', 'layer', 'render'}
RenderSystem.group = 'draw'
RenderSystem.sort = 'layer'

local ww, wh = love.graphics.getDimensions()

local box = false
function RenderSystem.update(e)
    local df = love.graphics.getFont()
    if box then
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle(
            'line', 
            e.x - e.width/2, e.y - e.height/2, e.width, e.height
        )
    end
    local rotation = 0
    if e.rotation then rotation = e.rotation end

    love.graphics.setColor(1, 1, 1)
    if e.alpha then
        love.graphics.setColor(1, 1, 1, e.alpha)
    end
    local sw = 1
    local sh = 1
    if e.image == 'rect' then
        love.graphics.rectangle(
            'fill', e.x - e.width/2, e.y-e.height/2, e.width, e.height
        )
    else
        local iw = e.image:getWidth()
        local ih = e.image:getHeight()
        sw = e.width/iw
        sh = e.height/ih
        if e.flip then
            sw = -sw
        end
        love.graphics.draw(
            e.image,
            e.x, e.y, rotation,
            sw, sh,
            iw/2, ih/2
        )
    end
    --love.graphics.circle('fill', e.x, e.y, 5)

    if e.eyesClosed then
        love.graphics.draw(e.eyelids, e.x - e.width/2, e.y - e.height/2, rotation, sw, sh)
    end

    if e.textCenter and e.text then
        local font = love.graphics.getFont()
        local w = font:getWidth(e.text)
        local h = font:getHeight()

        love.graphics.setColor(e.textColor)
        love.graphics.print(e.text, e.x - w/2, e.y - h/2)
    elseif e.text then
        love.graphics.setColor(e.textColor)
        local x = e.x - e.width/2
        local y = e.y - e.height/2
        love.graphics.printf(
            e.text, x + e.textX, y + e.textY, e.textWidth, 'left', rotation
        )
    end

    if e.isClipboard then
        love.graphics.setColor(e.textColor)
        local x = e.x - e.width/2 + e.textX
        local y = e.y - e.height/2 + e.textY
 
        -- HEADINGS
        local f = love.graphics.newFont('assets/mytype.ttf', 20)
        local smallf = love.graphics.newFont('assets/danielbd.ttf', 14)
        local fo = f:getHeight()/2 - smallf:getHeight()/2 + 4
        local line = f:getHeight() + 4
        love.graphics.setFont(f)
        -- Name
        love.graphics.printf(
            'NAME: ', x, y, e.textWidth, 'left'
        )
        local nw = f:getWidth('NAME: ')
        -- DOB/Sex
        local dobspace = e.textWidth*0.6
        love.graphics.printf(
            'DOB: ', x, y + line, e.textWidth, 'left'
        )
        local dw = f:getWidth('DOB: ')
        love.graphics.printf(
            'SEX: ', x + dobspace, y + line, e.textWidth, 'left'
        )
        local sw = f:getWidth('SEX: ')
        -- Diagnosis
        love.graphics.printf(
            'SYMPTOMS: ', x, y + line*2.25, e.textWidth, 'left'
        )
        local yw = f:getWidth('SYMPTOMS: ')
        -- Notes
        love.graphics.printf(
            'NOTES: ', x, y + line*4.75, e.textWidth, 'left'
        )
        local ow = f:getWidth('NOTES: ')

        ---[[
        -- INFO
        love.graphics.setFont(smallf)
        -- Name
        love.graphics.printf(
            e.name, x + nw, y + fo, e.textWidth, 'left'
        )
        -- DOB/Sex
        love.graphics.printf(
            e.birthday, x + dw, y + line + fo, e.textWidth, 'left'
        )
        love.graphics.printf(
            e.sex, x + dobspace + sw, y + line + fo, e.textWidth, 'left'
        )
        -- Symptoms
        love.graphics.printf(
            '                 '..e.symptoms, x, y + line*2.25 + fo, e.textWidth - yw, 'left'
        )
        --Notes
        love.graphics.printf(
            '           '..e.notes, x, y + line*4.75 +fo, e.textWidth - ow, 'left'
        )
    end

    if e.isMonitor then
        love.graphics.push()
        local mf = love.graphics.newFont('assets/VCR_OSD_MONO.ttf', 36)
        love.graphics.setFont(mf)
        love.graphics.setColor(0, 1, 0)
        -- love.graphics.translate(e.x, e.y)
        -- love.graphics.rotate(e.rotation)
        e.animation:draw(e.blip, e.x - 55, e.y - 60, 0, 0.20, 0.20)
        love.graphics.print('75', e.x + 25, e.y + 50)
        love.graphics.pop()
    end

    love.graphics.setFont(df)
end

local animationSys = secsi.system{'animation'}
function animationSys.update(e, dt)
  e.animation:update(dt)
end

--[[
local ClipBoardInfoRenderSystem = secsi.system{'name', 'symptoms', 'allergies', 'notes'}
ClipBoardInfoRenderSystem.group= 'draw'

function ClipBoardInfoRenderSystem.update(e)

    if e.isClipboard then
        love.graphics.setColor(e.textColor)
        local x = e.x - e.width/2 + e.textX
        local y = e.y - e.height/2 + e.textY
 
        -- HEADINGS
        local f = love.graphics.newFont('assets/mytype.ttf', 20)
        local smallf = love.graphics.newFont('assets/danielbd.ttf', 14)
        local fo = f:getHeight()/2 - smallf:getHeight()/2 + 4
        local line = f:getHeight() + 4
        love.graphics.setFont(f)
        -- Name
        love.graphics.printf(
            'NAME: ', x, y, e.textWidth, 'left'
        )
        local nw = f:getWidth('NAME: ')
        -- DOB/Sex
        local dobspace = e.textWidth*0.6
        love.graphics.printf(
            'DOB: ', x, y + line, e.textWidth, 'left'
        )
        local dw = f:getWidth('DOB: ')
        love.graphics.printf(
            'SEX: ', x + dobspace, y + line, e.textWidth, 'left'
        )
        local sw = f:getWidth('SEX: ')
        -- Diagnosis
        love.graphics.printf(
            'SYMPTOMS: ', x, y + line*2.25, e.textWidth, 'left'
        )
        local yw = f:getWidth('SYMPTOMS: ')
        -- Notes
        love.graphics.printf(
            'NOTES: ', x, y + line*4.75, e.textWidth, 'left'
        )
        local ow = f:getWidth('NOTES: ')

        ---[[
        -- INFO
        love.graphics.setFont(smallf)
        -- Name
        love.graphics.printf(
            e.name, x + nw, y + fo, e.textWidth, 'left'
        )
        -- DOB/Sex
        love.graphics.printf(
            e.birthday, x + dw, y + line + fo, e.textWidth, 'left'
        )
        love.graphics.printf(
            e.sex, x + dobspace + sw, y + line + fo, e.textWidth, 'left'
        )
        -- Symptoms
        love.graphics.printf(
            '                 '..e.symptoms, x, y + line*2.25 + fo, e.textWidth - yw, 'left'
        )
        --Notes
        love.graphics.printf(
            '           '..e.notes, x, y + line*4.75 +fo, e.textWidth - ow, 'left'
        )
    end
end
--]]

--[[
local hud = {}
hud.isHud = true
secsi.add(hud)
local DebugSystem = secsi.system{'isHud'}
DebugSystem.group = 'draw'
function DebugSystem.update(e)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.print('FPS: '..love.timer.getFPS(), 25, 25)
    love.graphics.print('Entities: '..#secsi.get(), 25, 50)
end
--]]