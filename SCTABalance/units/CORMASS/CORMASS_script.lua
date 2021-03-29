#ARM Moho Mine - Advanced Metal Extractor
#ARMMOHO
#
#Script created by Raevn

local TAMass = import('/mods/SCTA-master/lua/TAStructure.lua').TAMass

CORMASS = Class(TAMass) {

	OnCreate = function(self)
		TAMass.OnCreate(self)
		self.Spinners = {
			arms = CreateRotator(self, 'rotary', 'y', nil, 0, 0, 0),
			dingle1 = CreateRotator(self, 'dingle1', 'y', nil, 0, 0, 0),
			dingle2 = CreateRotator(self, 'dingle2', 'y', nil, 0, 0, 0),
			shell = CreateRotator(self, 'shell', 'x', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,


	OnStopBeingBuilt = function(self, builder, layer)
		TAMass.OnStopBeingBuilt(self, builder, layer)
		self:Open()
	end,

	OnProductionPaused = function(self)
		TAMass.OnProductionPaused(self)			
		self.Spinners.dingle1:SetGoal(0)
		self.Spinners.dingle1:SetSpeed(120)
		--TURN dingle2 to y-axis <0> SPEED <120.02>;
		self.Spinners.dingle2:SetGoal(0)
		self.Spinners.dingle2:SetSpeed(120)
		--MOVE stands to y-axis <10.35> SPEED <13.00>;
		self.Spinners.shell:SetGoal(0)
		self.Spinners.shell:SetSpeed(261)
	end,

	OnProductionUnpaused = function(self)
		TAMass.OnProductionUnpaused(self)
		self:Open()
	end,

	Open = function(self)
		self.Spinners.shell:SetGoal(-180)
		self.Spinners.shell:SetSpeed(261.68)
				--SPIN dingle1 around y-axis  SPEED spinspeed;
		self.Spinners.dingle1:ClearGoal()
		self.Spinners.dingle1:SetSpeed(self:GetProductionPerSecondMass() * 27)
		
				--SPIN dingle2 around y-axis  SPEED spinspeed;
		self.Spinners.dingle2:ClearGoal()
		self.Spinners.dingle2:SetSpeed(self:GetProductionPerSecondMass() * 27)
	end,
}

TypeClass = CORMASS