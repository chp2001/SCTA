#ARM Drake Gantry - Builds Drake
#ARMGANT
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

ARMGANT = Class(TAFactory) {
	pauseTime = 5,
	hideUnit = true,
	isFactory = true,
	spinUnit = false,

	OnCreate = function(self)
		TAFactory.OnCreate(self)
	end,


	Open = function(self)
		TAFactory.Open(self)
	end,

}

TypeClass = ARMGANT