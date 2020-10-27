#CORE Spectre - Radar Jammer
#CORSPEC
#
#Script created by Raevn

local TAWalking = import('/mods/SCTA-master/lua/TAWalking.lua').TAWalking


CORSPEC = Class(TAWalking) {
	OnCreate = function(self)
		TAWalking.OnCreate(self)

		self.Spinners = {
			
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,

	Close = function(self)
		self:PlayUnitSound('Deactivate')

		
	end,

	Open = function(self)
		self:PlayUnitSound('Activate')

		
	end,

	OnIntelDisabled = function(self)
		TAWalking.OnIntelDisabled(self)
		ForkThread(self.Close, self)
	end,

	OnIntelEnabled = function(self)
		TAWalking.OnIntelEnabled(self)
		ForkThread(self.Open, self)
		
	end,
}
TypeClass = CORSPEC