#CORE Sonar Station - Sonar Station
#CORSONAR
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure

CORSONAR = Class(TAStructure) {

	OnCreate = function(self)
		TAStructure.OnCreate(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 0, 0),
		}
		self.Trash:Add(self.Spinners.base)
	end,

	OnIntelDisabled = function(self)
		--SPIN base around y-axis  SPEED <0>;
		self.Spinners.dish:SetSpeed(0)
		TAStructure.OnIntelDisabled(self)
		self:PlayUnitSound('Deactivate')
	end,

	OnIntelEnabled = function(self)
		--SPIN base around y-axis  SPEED <60.01>;
		self.Spinners.dish:SetSpeed(60)
		TAStructure.OnIntelEnabled(self)
		self:PlayUnitSound('Activate')
	end,
}

TypeClass = CORSONAR
