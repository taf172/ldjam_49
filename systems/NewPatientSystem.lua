local secsi = require 'secsi'
local Game = require 'entities.Game'
local Cat = require 'entities.Cat'
local Button = require 'entities.Cat'

local spawner = {isSpawner = true}
secsi.add(spawner)

local ww, wh = love.graphics.getDimensions()

local rollOutTime = 0.25
local rollInTime = 1.5
local lagTime = 0.25

local NewPatientSystem = secsi.system{'isSpawner'}
local spawnTimer = 0
local spawnNew = true
local outSound = love.audio.newSource('assets/sounds/swoosh.wav', 'static')
local inSound = love.audio.newSource('assets/sounds/bedroll.wav', 'static')
local rollingOver = false
local scribbleSound = love.audio.newSource('assets/sounds/scribble.wav', 'static')
local clipboardUpTimer = 0
local clipboardUpTime = 2

function NewPatientSystem.update(e, dt)
    if Game.currentPatient.gone and not spawnNew then
        local bed = Game.bed
        bed.tweens.x = {ww + bed.width/2, rollOutTime, 'linear'}
        bed.tweens.y = {wh/2, rollOutTime, 'linear'}
        spawnNew = true
        spawnTimer = 0
        outSound:play()

        local cb = Game.clipboard
        cb.tweens.x = {cb.hoverOff.x, 0.5, 'linear'}
        cb.tweens.y = {cb.hoverOff.y, 0.5, 'linear'}
        cb.hover = false

    end

    if spawnNew then
        spawnTimer = spawnTimer + dt
    end

    if spawnNew and spawnTimer >= rollOutTime + lagTime then
        local cp = Game.currentPatient
        local new
        if cp.firstPatient then
            cp.firstPatient = false
            new = cp
        else
            Game.currentPatient:remove()
            new = Cat()
        end
        local bed = Game.bed
        bed.tweens.x = {ww/2, rollInTime, 'cubicOut'}
        bed.tweens.y = {wh/2, rollInTime, 'cubicOut'}
        new.x = ww + bed.width/2
        new.y = wh/2
        new.tweens.x = {ww/2, rollInTime, 'cubicOut'}
        new.tweens.y = {wh/2, rollInTime, 'cubicOut'}
        Game.currentPatient = new
        spawnNew = false
        rollingOver = true
        inSound:play()
    end

    if rollingOver and Game.currentPatient.x <= ww/2 + 1 then
        Game.pillbottle.reset = true
        local cb = Game.clipboard
        scribbleSound:play()
        cb.patient = Game.currentPatient
        cb.tweens.x = {cb.hoverTo.x, 0.5, 'quadOut'}
        cb.tweens.y = {cb.hoverTo.y, 0.5, 'quadOut'}
        rollingOver = false
    end

    if not (spawnNew or rollingOver or Game.clipboard.hover) then
        clipboardUpTimer = clipboardUpTimer + dt
        if clipboardUpTimer > clipboardUpTime then
            local cb = Game.clipboard
            cb.hoveringTo = true
            cb.hover = true
            clipboardUpTimer = 0
        end
    end
end