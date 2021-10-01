local secsi = require 'libs.secsi'
local Game = require 'entities.game'
local Button = require 'entities.button'

local StateSystem = secsi.system{'state'}

local ww, wh = love.graphics.getDimensions()
local state = secsi.add{
    playing = true,
    state = true
}
local restartButton = Button()
secsi.remove(restartButton)
restartButton.text = 'RESTART'
restartButton.x = ww/2
restartButton.y = wh*2/3

function StateSystem.update(e)
    if restartButton.pressed then
        e.restart = true
        restartButton.pressed = false
        secsi.remove(restartButton)
    end

    if e.playing then
        if Game.player.dead then
            e.playing = false
            e.gameover = true
        end
    end

    if e.gameover then
        if Game.score > Game.highscore then
            Game.highscore = Game.score
        end
        Game.hud.showGameover = true
        e.gameover = false
        secsi.add(restartButton)
    end

    if e.restart then
        e.restart = false
        e.playing = true
        Game.hud.showGameover = false
        Game.player.dead = false
        Game.player.onPlatform = Game.ground
        Game.platforms.reset = true
        Game.camera.tracking = Game.player
        Game.score = 0
        secsi.remove(restartButton)
    end

end