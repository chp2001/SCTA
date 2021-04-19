#ARM Metal Extractor - Extracts Metal
#ARMMEX
#
#Script created by Raevn

local TAMass = import('/mods/SCTA-master/lua/TAStructure.lua').TAMass

ARMMEX = Class(TAMass) {
	OnCreate = function(self)
		TAMass.OnCreate(self)
		self.Spinners = {
			arms = CreateRotator(self, 'arms', 'y', nil, 0, 91, 0),
		}
		self.Trash:Add(self.Spinners.arms)
	end,
}

TypeClass = ARMMEX