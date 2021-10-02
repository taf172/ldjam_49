local Player = require 'entities.player'
local Platform = require 'entities.platform'
local PlatformSpawner = require 'entities.platformspawner'
local Camera = require 'entities.camera'
local Hud = require 'entities.hud'

local ww, wh = love.graphics.getDimensions()

local function color(r, g, b)
    return {r/255, g/255, b/255}
end

local Game = {}
local ground = Platform()
local player = Player()
local platforms = PlatformSpawner()
local camera = Camera()
local hud = Hud()
--[[
local testButton = Button()
testButton.giveComponent = {
    entity = player,
    component = 'jump',
    value = 'true',
}
--]]

ground.width = ww
ground.height = wh/3
ground.x = ww/2
ground.y = wh*2/3 + ground.height/2
ground.tweens = nil

player.x = ww/2
player.y = wh*2/3 - 32
player.onPlatform = ground

platforms.x = ground.x
platforms.y = ground.y - ground.height/2

camera.tracking = player

Game.bgColor = color(72, 117, 101)
ground.color = color(200, 219, 156)
platforms.color = color(200, 219, 156)
player.color = color(219, 138, 222)
player.trailColor = color(	117, 255, 255 )

Game.ground = ground
Game.player = player
Game.platforms = platforms
Game.camera = camera
Game.hud = hud
Game.score = 0
Game.highscore = 0
return Game