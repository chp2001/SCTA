#ARM Moho Mine - Advanced Metal Extractor
#ARMMOHO
#
#Script created by Raevn

local TAMass = import('/mods/SCTA-master/lua/TAStructure.lua').TAMass

ARMMOHO = Class(TAMass) {

	OnCreate = function(self)
		TAMass.OnCreate(self)
		self.Spinners = {
			arms = CreateRotator(self, 'blade', 'y', nil, 0, 91, 0),
		}
		self.Trash:Add(self.Spinners.arms)
	end,

}

TypeClass = ARMMOHO