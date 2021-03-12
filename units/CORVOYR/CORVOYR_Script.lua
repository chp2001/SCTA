#ARM Flea - Fast Light Scout Kbot
#CORVOYR
#
#Script created by Raevn

local TACounter = import('/mods/SCTA-master/lua/TAMotion.lua').TACounter


CORVOYR = Class(TACounter) {
	
	OnCreate = function(self)
		TACounter.OnCreate(self)
		self.Spinners = {
			dish1 = CreateRotator(self, 'dish1', 'y', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TACounter.OnStopBeingBuilt(self,builder,layer)
		self.Spinners.dish1:SetSpeed(90)
	end,
}

TypeClass = CORVOYR
