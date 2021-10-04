local secsi = require 'secsi'
local Game = require 'entities.game'

local RenderSystem = secsi.system{ 'x', 'y', 'image', 'layer', 'render'}
RenderSystem.group = 'draw'
RenderSystem.sort = 'layer'

local ww, wh = love.graphics.getDimensions()

local box = false
function RenderSystem.update(e)
    local dfilt = love.graphics.getDefaultFilter()
    local df = love.graphics.getFont()
    if box then
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle(
            'line', 
            e.x - e.width/2, e.y - e.height/2, e.width, e.height
        )
    end

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
    elseif not e.isMonitor then
        local iw = e.image:getWidth()
        local ih = e.image:getHeight()
        local r = 0
        sw = e.width/iw
        sh = e.height/ih
        if e.flip then sw = -sw end
        if e.rotation then r = e.rotation end
        love.graphics.draw(
            e.image,
            e.x, e.y, r,
            sw, sh,
            iw/2, ih/2
        )
    end

    if e.icon then
        love.graphics.setColor{1, 1, 1}
        local iw = e.icon:getWidth()
        local ih = e.icon:getHeight()
        sw = e.iconWidth/iw
        sh = e.iconHeight/ih
        love.graphics.draw(
            e.icon,
            e.x + e.iconX, e.y + e.iconY, e.iconRotation,
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
            e.text, x + e.textX, y + e.textY, e.textWidth, 'left'
        )
    end

    if e.isClipboard then
        local dfilter = love.graphics.getDefaultFilter()
        love.graphics.setDefaultFilter('nearest', 'nearest')
        love.graphics.setColor(e.textColor)
        local x = e.x - e.width/2 + e.textX
        local y = e.y - e.height/2 + e.textY
 
        -- HEADINGS
        local f = love.graphics.newFont('assets/fonts/mytype.ttf', 20)
        local smallf = love.graphics.newFont('assets/fonts/danielbd.ttf', 14)
        local fo = f:getHeight()/2 - smallf:getHeight()/2 + 4
        local line = f:getHeight()
        love.graphics.setFont(f)
        -- Gen Info
        love.graphics.printf(
            'NAME: ', x, y, e.textWidth, 'left'
        )
        local nw = f:getWidth('NAME: ')
        local dobspace = e.width/2
        love.graphics.printf(
            'DOB: ', x, y + line, e.textWidth, 'left'
        )
        local dw = f:getWidth('DOB: ')
        love.graphics.printf(
            'SEX: ', x + dobspace, y + line, e.textWidth, 'left'
        )
        local gw = f:getWidth('SEX: ')

        -- Symptoms
        love.graphics.printf(
            'SYMPTOMS: ', x, y + line*2.25, e.textWidth, 'left'
        )
        -- Alergies
        love.graphics.printf(
            'ALLERGIES: ', x, y + line*4.25, e.textWidth, 'left'
        )
        -- Notes
        love.graphics.printf(
            'NOTES: ', x, y + line*6.25, e.textWidth, 'left'
        )

        ---[[
        -- INFO
        local p = Game.currentPatient
        love.graphics.setFont(smallf)
        -- Name
        love.graphics.printf(
            p.name, x + nw, y + fo, e.textWidth, 'left'
        )
        -- DOB/Sex
        love.graphics.printf(
            p.birthday, x + dw, y + line + fo, e.textWidth, 'left'
        )
        love.graphics.printf(
            p.sex, x + dobspace + gw, y + line + fo, e.textWidth, 'left'
        )
        -- Symptoms
        love.graphics.printf(
            '                  '..p.symptoms, x, y + line*2.25 + fo, e.textWidth, 'left'
        )
        -- Allergies
        --[[
        love.graphics.printf(
            '                   '..p.allergies, x, y + line*4.25 +fo, e.textWidth, 'left'
        )
        --]]
        love.graphics.setDefaultFilter(dfilter)
        --Notes
        love.graphics.printf(
            '            '..p.notes, x, y + line*6.25 +fo, e.textWidth, 'left'
        )
        love.graphics.setDefaultFilter(dfilter)
    end

    if e.isMonitor then

        local mf = love.graphics.newFont('assets/fonts/VCR_OSD_MONO.ttf',36)
        local iw = e.image:getWidth()
        local ih = e.image:getHeight()
        sw = e.width/iw
        sh = e.height/ih
        if e.flip then
            sw = -sw
        end
        love.graphics.push()
        love.graphics.setFont(mf)
        love.graphics.translate(e.x, e.y)
        love.graphics.rotate(math.rad(e.rotation))
        love.graphics.draw(
            e.image,
            0, 0, 0,
            sw, sh,
            iw/2, ih/2
        )
        
        local bs = 0.35
        e.animation:draw(e.blip, -100, -100, 0, bs, bs)
        love.graphics.setColor(0, 1, 0)
        local px = -90
        local py = 40
        love.graphics.print('BPM'..Game.currentPatient.heartrate, px, py)
        love.graphics.print('PL'..Game.lives, px + 140, py)
        love.graphics.pop()
    end

    if e.pages and e.open then
        local dfilter = love.graphics.getDefaultFilter()
        love.graphics.setDefaultFilter('nearest', 'nearest')
        local p1 = e.pages[e.onPage]
        local p2 = e.pages[e.onPage + 1]

        local pf = love.graphics.newFont('assets/fonts/Montserrat-Bold.ttf', 26)
        local pfs = love.graphics.newFont('assets/fonts/PlayfairDisplay-Regular.ttf', 18)
        local pfsb = love.graphics.newFont('assets/fonts/PlayfairDisplay-Bold.ttf', 18)
        local pnf = love.graphics.newFont('assets/fonts/Montserrat-Bold.ttf', 20)
        local lh = pfs:getHeight()

        love.graphics.setColor{0, 0, 0}

        -- Page numbers
        local pny = e.y + e.height/3 + 20
        love.graphics.setFont(pnf)
        love.graphics.print(e.onPage, e.x - e.width/2 + 75, pny)
        love.graphics.print(e.onPage + 1, e.x + e.width/2 - 80, pny - 10)

        -- Name
        love.graphics.setFont(pf)
        local n1x = e.x - e.width/2 + 75
        local n1y = e.y - e.height/2 + e.height/4
        local pw1 = (e.x - n1x) - 20
        love.graphics.printf(p1.name, n1x, n1y, pw1, 'center')

        local n2x = e.x + 30
        local n2y = e.y - e.height/2 + e.height/4
        local pw2 = pw1
        love.graphics.printf(p2.name, n2x, n2y, pw2, 'center')

        love.graphics.setFont(pfs)
        -- Left page
        local p1x = n1x
        local p1y = n1y + pf:getHeight()*1.5
        love.graphics.printf('                             '..p1.symptoms, p1x, p1y, pw1, 'left')
        local ph = lh*2
        local steph = lh*2.25
        local stuffy = lh + ph + 30

        love.graphics.printf('                 '..p1.step1, p1x, p1y + stuffy, pw1, 'left')
        love.graphics.printf('                 '..p1.step2, p1x, p1y + stuffy + steph, pw1, 'left')
        love.graphics.printf('                 '..p2.step2, p1x, p1y + stuffy + steph*2, pw1, 'left')

        -- Right page
        local p2x = n2x
        local p2y = n2y + pf:getHeight()*1.5
        love.graphics.printf('                             '..p2.symptoms, p2x, p2y, pw2, 'left')
        
        love.graphics.setFont(pfsb)
        love.graphics.printf('SYMPTOMS: ', p1x, p1y, pw1, 'left')
        love.graphics.printf('PROCEDURE', p1x, p1y + lh + ph - 5, pw1, 'center')
        love.graphics.printf('STEP 1: ', p1x, p1y + stuffy, pw1, 'left')
        love.graphics.printf('STEP 2: ', p1x, p1y + stuffy + steph, pw1, 'left')
        love.graphics.printf('STEP 3: ', p1x, p1y + stuffy + steph*2, pw1, 'left')
        love.graphics.printf('SYMPTOMS: ', p2x, p2y, pw2, 'left')
        love.graphics.printf('PROCEDURE', p2x, p2y + lh + ph - 5, pw2, 'center')
        love.graphics.printf('STEP 1: ', p2x, p1y + stuffy, pw1, 'left')
        love.graphics.printf('STEP 2: ', p2x, p1y + stuffy + steph, pw1, 'left')
        love.graphics.printf('STEP 3: ', p2x, p1y + stuffy + steph*2, pw1, 'left')

        love.graphics.setDefaultFilter(dfilter)
    end

    love.graphics.setFont(df)
    love.graphics.setDefaultFilter(dfilt)
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
        local f = love.graphics.newFont('assets/fonts/mytype.ttf', 20)
        local smallf = love.graphics.newFont('assets/fonts/danielbd.ttf', 14)
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