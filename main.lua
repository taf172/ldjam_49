local ww, wh = 960, 720
love.window.setMode(ww, wh)
--love.graphics.setDefaultFilter("nearest","nearest")
love.mouse.setVisible(false)

local secsi = require 'secsi'
local Game = require 'entities.game'

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

-- music: https://www.strofe.com/
-- sound fx: 
-- art:

function love.draw()
    secsi.update(0, 'draw')
end

function love.update(dt)
    secsi.update(dt)
end