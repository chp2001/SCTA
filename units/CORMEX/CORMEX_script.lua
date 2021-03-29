#CORE Metal Extractor - Extracts Metal
#CORMEX
#
#Script created by Raevn

local TAMass = import('/mods/SCTA-master/lua/TAStructure.lua').TAMass

CORMEX = Class(TAMass) {
	OnCreate = function(self)
		TAMass.OnCreate(self)
		self.Spinners = {
			arms = CreateRotator(self, 'arms', 'y', nil, 0, 91, 0),
		}
		self.Sliders = {
			stand = CreateSlider(self, 'stand'),
		}
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,

	OnStopBeingBuilt = function(self, builder, layer)
		TAMass.OnStopBeingBuilt(self, builder, layer)
		self:Open()
	end,

	Open = function(self)
		self.Sliders.stand:SetGoal(0,6,0)
		self.Sliders.stand:SetSpeed(6)
	end,

	OnProductionPaused = function(self)
		TAMass.OnProductionPaused(self)
		self.Sliders.stand:SetGoal(0,0,0)
		self.Sliders.stand:SetSpeed(6)
		self.Spinners.arms:SetGoal(0)
		self.Spinners.arms:SetSpeed(35)
	end,

	OnProductionUnpaused = function(self)
		TAMass.OnProductionUnpaused(self)
		self:Open()
	end,
}

TypeClass = CORMEX