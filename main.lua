local ww, wh = 960, 720
love.window.setMode(ww, wh)
love.graphics.setDefaultFilter("nearest","nearest")
love.mouse.setVisible(false)

local secsi = require 'secsi'
local Bed = require 'entities.bed'
local Cat = require 'entities.cat'
local Clipboard = require 'entities.clipboard'
local Monitor = require 'entities.monitor'
local Arm = require 'entities.arm'

require 'systems.RenderSystem'
require 'systems.HoverSystem'
require 'systems.TweeningSystem'
require 'systems.ArmSystem'
require 'systems.ButtonSystem'
require 'systems.PatientSystem'
require 'systems.AnimationSystem'

-- music: https://www.strofe.com/
-- sound fx: 
-- art:

local bed = Bed()
local cat = Cat()
local clip = Clipboard()
local monitor = Monitor()
local arm = Arm()

function love.draw()
    secsi.update(0, 'draw')
end

function love.update(dt)
    secsi.update(dt)
end