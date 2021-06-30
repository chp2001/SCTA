#ARM Aircraft Plant - Produces Aircraft
#ARMDAP
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory

ARMADAP = Class(TAFactory) {
	OnCreate = function(self)
		self.Spinners = {
			radar = CreateRotator(self, 'Radar', 'y', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		TAFactory.OnCreate(self)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAFactory.OnStopBeingBuilt(self,builder,layer)
		self.Spinners.radar:SetSpeed(45)
	end,
}

TypeClass = ARMADAP