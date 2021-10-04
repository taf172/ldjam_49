local ww, wh = 960, 720
love.window.setMode(ww, wh)

--love.graphics.setDefaultFilter("nearest","nearest")
--love.mouse.setVisible(false)

local secsi = require 'secsi'
local Game = require 'entities.Game'

require 'systems.RenderSystem'
require 'systems.HoverSystem'
require 'systems.TweeningSystem'
require 'systems.ArmSystem'
require 'systems.ButtonSystem'
require 'systems.PatientSystem'
require 'systems.AnimationSystem'
require 'systems.ParticleSystem'
require 'systems.NewPatientSystem'
require 'systems.BookSystem'
require 'systems.DispenseSystem'
require 'systems.DiseaseSystem'
require 'systems.HeartRateSystem'
require 'systems.TitleScreenSystem'

local music = love.audio.newSource('assets/sounds/music.mp3', 'static')
music:setVolume(0.2)
music:setLooping(true)
music:play()

-- music: https://www.strofe.com/
-- sound fx: 
-- art:
local bg = {
    image = love.graphics.newImage('assets/background.png'),
    render = true,
    layer = - 10,
    x = ww/2, y = wh/2,
    width = ww, height = wh,
}
secsi.add(bg)

local pb = {
}

function love.draw()
    secsi.update(0, 'draw')
end

function love.update(dt)
    if Game.title then
        secsi.update(dt, 'title')
        return
    end
    secsi.update(dt)
end