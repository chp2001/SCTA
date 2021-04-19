#ARM Adv. Aircraft Plant - Produces Aircraft
#ARMAAP
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory

ARMAAP = Class(TAFactory) {
	OnCreate = function(self)
		self.Spinners = {
			radar = CreateRotator(self, 'radar', 'y', nil, 0, 0, 0),
			nozzle1 = CreateRotator(self, 'Nozzle_01', 'y', nil, 0, 0, 0),
			nozzle2 = CreateRotator(self, 'Nozzle_02', 'y', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		TAFactory.OnCreate(self)
	end,


	Open = function(self)
		TAFactory.Open(self)
		
		self.Spinners.nozzle1:SetGoal(45)
		self.Spinners.nozzle1:SetSpeed(160.03)

		self.Spinners.nozzle2:SetGoal(-45)
		self.Spinners.nozzle2:SetSpeed(160.03)
	end,


	Close = function(self)
		TAFactory.Close(self)

		self.Spinners.nozzle1:SetGoal(0)
		self.Spinners.nozzle1:SetSpeed(160.03)

		self.Spinners.nozzle2:SetGoal(0)
		self.Spinners.nozzle2:SetSpeed(160.03)
	end,


	OnStopBeingBuilt = function(self,builder,layer)
		TAFactory.OnStopBeingBuilt(self,builder,layer)
		self.Spinners.radar:SetSpeed(45)
	end,

}

TypeClass = ARMAAP