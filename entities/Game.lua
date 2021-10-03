local Bed = require 'entities.bed'
local Cat = require 'entities.cat'
local Clipboard = require 'entities.clipboard'
local Monitor = require 'entities.monitor'
local Arm = require 'entities.arm'

local ww, wh = love.graphics.getDimensions()

local Game = {}
Game.currentPatient = Cat()
Game.bed = Bed()
Game.clipboard = Clipboard()
Game.monitor = Monitor()
Game.arm = Arm()

return Game