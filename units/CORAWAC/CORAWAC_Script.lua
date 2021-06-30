#COR Vulture - Radar Plane
#CORAWAC
#
#Script created by Raevn

local TAIntelAir = import('/mods/SCTA-master/lua/TAair.lua').TAIntelAir

CORAWAC = Class(TAIntelAir) {

	OnCreate = function(self)
		TAIntelAir.OnCreate(self)
		self.Spinners = {
			radar = CreateRotator(self, 'radar', 'y', nil, 0, 0, 0),
			Rwing = CreateRotator(self, 'Rwing', 'z', nil, 0, 0, 0),
			Lwing = CreateRotator(self, 'Lwing', 'z', nil, 0, 0, 0),
		}
		
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAIntelAir.OnStopBeingBuilt(self,builder,layer)
		self.Spinners.radar:SetSpeed(60)
	end,

	OpenWings = function(self)
		--TURN Rwing to z-axis <-90.12> SPEED <61.86>;
		self.Spinners.Rwing:SetGoal(90)
		self.Spinners.Rwing:SetSpeed(61)

		--TURN Lwing to z-axis <90.12> SPEED <61.86>;
		self.Spinners.Lwing:SetGoal(-90)
		self.Spinners.Lwing:SetSpeed(61)
	end,

	CloseWings = function(self)
		--TURN Rwing to z-axis <0> SPEED <61.95>;
		self.Spinners.Rwing:SetGoal(0)
		self.Spinners.Rwing:SetSpeed(61)

		--TURN Lwing to z-axis <0> SPEED <61.95>;
		self.Spinners.Lwing:SetGoal(0)
		self.Spinners.Lwing:SetSpeed(61)
	end,
}

TypeClass = CORAWAC