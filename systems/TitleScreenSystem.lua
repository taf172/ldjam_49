local secsi = require 'secsi'
local Button = require 'entities.Button'
local Game = require 'entities.Game'

local TitleScreenSystem = secsi.system{'playButton'}
TitleScreenSystem.group = 'title'

local ww, wh = love.graphics.getDimensions()
local ts = {
    image = love.graphics.newImage('assets/title.png'),
    render = true,
    layer = 100,
    x = ww/2, y = wh/2,
    width = ww, height = wh,
}
secsi.add(ts)

local pb = Button()
pb.text = 'PLAY'
pb.alpha = 1
pb.color = {0.5, 0.5, 0.5}
pb.textColor = {1, 1, 1}
pb.x = ww*2/3 + 45
pb.y = wh/2
pb.layer = 101
pb.width = 250
pb.height = 100
pb.playButton = true

local mh = false
local df = love.graphics.getFont()
local f = love.graphics.newFont('assets/fonts/Montserrat-Bold.ttf', 36)
love.graphics.setFont(f)

function TitleScreenSystem.update(e)
    local mx, my = love.mouse.getPosition()
    local md = love.mouse.isDown(1)
    if mx > e.x - e.width/2 and mx < e.x + e.width/2
    and my > e.y - e.height/2 and my < e.y + e.height/2 
    and md and not mh then
        Game.title = false
        love.mouse.setVisible(false)
        secsi.remove(ts)
        pb:remove()
    end
    mh = md
end