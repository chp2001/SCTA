#CORE Adv. Aircraft Plant - Produces Aircraft
#CORAAP
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory


CORAAP = Class(TAFactory) {
	OnCreate = function(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		TAFactory.OnCreate(self)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAFactory.OnStopBeingBuilt(self,builder,layer)
		self.Spinners.dish:SetSpeed(150)
	end,

}

TypeClass = CORAAP