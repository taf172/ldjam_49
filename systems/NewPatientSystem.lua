local secsi = require 'secsi'
local Game = require 'entities.game'
local Cat = require 'entities.cat'
local Button = require 'entities.cat'

local spawner = {isSpawner = true}
secsi.add(spawner)

local ww, wh = love.graphics.getDimensions()

local rollOutTime = 0.25
local rollInTime = 0.5

local NewPatientSystem = secsi.system{'isSpawner'}
function NewPatientSystem.update(e)
    if Game.currentPatient.gone then
        Game.currentPatient:remove()


        local bed = Game.bed
        local new = Cat()
        bed.tweens.x = {ww + bed.width/2, rollOutTime, 'linear'}
        bed.tweens.x.onComplete = {ww/2, rollInTime, 'quadOut'}
        bed.tweens.y = {wh/2, rollOutTime, 'linear'}
        bed.tweens.y.onComplete = {wh/2, rollInTime, 'quadOut'}

        new.x = ww + bed.width/2
        new.y = wh/2
        new.tweens.x = {ww/2, rollInTime, 'quadOut', wait = rollOutTime}
        new.tweens.y = {wh/2, rollInTime, 'quadOut', wait = rollOutTime}

        Game.currentPatient = new
    end
end