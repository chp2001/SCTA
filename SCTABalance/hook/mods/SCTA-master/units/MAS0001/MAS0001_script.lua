
local oldMAS0001 = MAS0001

MAS0001 = Class(oldMAS0001) {
    OnStopBeingBuilt = function(self,builder,layer)
		self:RemoveBuildRestriction(categories.CYBRAN)
		if __blueprints['xnl0001'] then
			self:RemoveBuildRestriction(categories.NOMADS)
		end
		oldMAS0001.OnStopBeingBuilt(self,builder,layer)
    end,
}


TypeClass = MAS0001

