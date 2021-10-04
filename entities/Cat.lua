local secsi = require 'secsi'

local Cat = secsi.entity{
    render = true,
    layer = 0,
    isPatient = true
}

local names = {
    'Little Booty Ham Sandwich',
    'Dog The Cat',
    'Fifty Shades Of Graham',
    'Isaac Mewton',
    'Jabba The Butt',
    'Ninja Killer Nine Thousand',
    'Obi Wan Catnobi',
    'The Great Catsby',
    'Whiskerus Maximus',
    'Winston Purrchill',
    'Amazes Me Penelope',
    'Bowie Spartacus',
    'Chicken Pants',
    'Cisco Allen Mcflashkitty',
    'Count Wigglybutt',
    'Disco Cheetah',
    'Draco Meowfoy',
    'Dutchess Mouse Mcmittens',
    'Foxy Spreadsheets',
    'Humphrey Bojangles',
    'Jonathan Supersocks',
    'Maximus Mcmarbles',
    'Monochromaticat',
    'Motley Crouton',
    'Mrs. Meowgi',
    'Newton Reginald Schibbelhut',
    'Old Man Hands',
    'Pepper Blue Hotsauce Peters',
    'Pistachio Buttons',
    'Pocket Change',
    'Princess Fairy Boots',
    'Reece Whiskerspoon',
    'Sassy Oil Spot',
    'Scratchy Sir Purr',
    'Sergeant Snuggles',
    'Sir Boots N Pants',
    'Spartacus Creamsicle',
    'Stinky Poo Poos',
    'Sugar Britches',
    'Sunny Summersunburst',
    'The Little Muffin Man',
    'The Princess Sofia Bean The Third Esq',
    'Thumbs Hemingway',
    'Tiny Thursday',
    'Tom Brady The Cat',
    'Toothless Truffle',
    'Trouble Boogers',
    'Tumtum Mcpuff',
    'Tybalt Copperpot',
    'Wendy Wondercat',
}
local notes = {
    'Likes long walks on the beach',
    'Just a computer simulation',
    'Fights aliens',
    'Fully functional as a pencil sharpener',
    'Unironically wears corduroy',
    'Kissed a sea lion and liked it',
    'Drives tug boats',
    'No longer allowed in IHOP',
    'Ladybug truther',
    'Golf caddy to Tiger Woods\' golf caddy',
    'Saw a whole rock once',
    'Can name every cheese in Wisconsin',
    'Racing legend',
    'Prolific fan-fiction author',
    'Plays guitar',
    'Thought Tortuga was a liqueur',
    'Disco sensation',
    'Watched Cardcaptors with subs',
    'Allergic to shallots',
    'Sore loser',
    'Spelled spelt \"spelled\"',
    '70% water',
    'Regular at local indie wrestling',
    'Still playing Paladins',
    'Followed Elton John on tour',
}

local allergies = {
}
local symptoms = {
}

local ww, wh = love.graphics.getDimensions()
local lastCat = 1
local nCats = 4
function Cat:init()
    local n = math.random(1, nCats)
    if n == lastCat then n = (n+1)%4 end
    lastCat = n
    self.image = love.graphics.newImage('assets/cats/cat'..n..'.png')
    self.eyelids = love.graphics.newImage('assets/cats/eyes'..n..'.png')
    self.height = wh - 100
    self.width = self.image:getWidth()*(self.height/self.image:getHeight())
    self.x = ww/2
    self.y = wh/2
    self.eyesClosed = true
    self.heartrate = 65 + math.random(1, 15)
    self.tweens = {}

    self.name = names[math.random(1,#names)]
    self.symptoms = "Cough, Fever, Eye Boogies"
    self.allergies = {
        green = true
    }
    self.notes = notes[math.random(1,#notes)]

    local month = math.random(1,12)
    local day = math.random(1, 31)
    local year = math.random(1960, 2010)
    local sex = 'M'
    if math.random() > 0.5 then
        sex = 'F'
    end
    self.sex = sex
    self.birthday = month..'/'..day..'/'..year

    self.pillsTaken= {}
    self.disease = 'Tutorialitis'
    self.phase = 1
end

return Cat