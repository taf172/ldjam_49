local secsi = require 'secsi'
local Game = require 'entities.game'
local Cat = require 'entities.cat'
local Button = require 'entities.cat'

local spawner = {isSpawner = true}
secsi.add(spawner)

local ww, wh = love.graphics.getDimensions()

local NewPatientSystem = secsi.system{'isSpawner'}
function NewPatientSystem.update(e)
    if Game.currentPatient.gone then
        Game.currentPatient:remove()
        Game.currentPatient = Cat()
    end
end