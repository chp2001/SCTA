#ARM Adv. Aircraft Plant - Produces Aircraft
#CORPLAT
#
#Script created by Raevn

local TASeaPlat = import('/mods/SCTA-master/lua/TAFactory.lua').TASeaPlat


CORPLAT = Class(TASeaPlat) {

	--[[OnStopBuild = function(self, unitBuilding)
		TAFactory.OnStopBuild(self, unitBuilding)
		if not self.Water and EntityCategoryContains(categories.HOVER, unitBuilding) then
			ForkThread(self.Rolling, self)
		end
	end,

	Rolling = function(self)
		self.Sliders.chassis:SetSpeed(10)
			self.Sliders.chassis:SetGoal(0,-10,0)
			WaitSeconds(1)
			self.Sliders.chassis:SetSpeed(10)
			self.Sliders.chassis:SetGoal(0,0,0)
	end,]]
}

TypeClass = CORPLAT