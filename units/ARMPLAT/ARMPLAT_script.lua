#ARM Adv. Aircraft Plant - Produces Aircraft
#ARMAAP
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

ARMAAP = Class(TAFactory) {
	pauseTime = 5,
	hideUnit = true,
	isFactory = true,
	spinUnit = false,

	OnCreate = function(self)
		TAFactory.OnCreate(self)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAFactory.OnStopBeingBuilt(self,builder,layer)
	end,

	Open = function(self)
		TAFactory.Open(self)
	end,

	Aim = function(self, target)
		TAFactory.Aim(self, target)
	end,

	Close = function(self)
		TAFactory.Close(self)
	end,
}

TypeClass = ARMAAP