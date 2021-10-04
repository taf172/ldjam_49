local Bed = require 'entities.bed'
local Cat = require 'entities.cat'
local Clipboard = require 'entities.clipboard'
local Monitor = require 'entities.monitor'
local Arm = require 'entities.arm'
local Book = require 'entities.book'
local Pill = require 'entities.pill'
local PillBottle = require 'entities.pillbottle'

local ww, wh = love.graphics.getDimensions()

local Game = {}
Game.currentPatient = Cat()
Game.bed = Bed()
Game.clipboard = Clipboard()
Game.monitor = Monitor()
Game.arm = Arm()
Game.book = Book()
Game.pillbottle = PillBottle()
Game.lives = 3

return Game