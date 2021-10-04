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
Game.clipboard = Clipboard()
Game.clipboard.hover = false
Game.monitor = Monitor()
Game.arm = Arm()
Game.book = Book()
Game.pillbottle = PillBottle()
Game.lives = 3

local b = Bed()
b.x = ww + b.width/2
Game.bed = b

local c = Cat()
c.image = love.graphics.newImage('assets/cats/cat4.png')
c.eyelids = love.graphics.newImage('assets/cats/eyes4.png')
c.height = wh - 100
c.width = c.image:getWidth()*(c.height/c.image:getHeight())
c.x = b.x
c.tutorial = true
c.firstPatient = true
c.name = 'Mr. Tutoral Cat'
c.sex = 'M'
c.disease = 'Tutorialitis'
c.allergies = {green = true}
c.notes = 'Check your trusty medical book'

Game.currentPatient = c
Game.clipboard.patient = c

return Game