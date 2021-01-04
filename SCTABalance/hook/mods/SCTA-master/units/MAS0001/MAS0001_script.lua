
local oldMAS0001 = MAS0001

MAS0001 = Class(oldMAS0001) {
    OnStopBeingBuilt = function(self,builder,layer)
		self:RemoveBuildRestriction(categories.AEON)
		self:RemoveBuildRestriction(categories.UEF)
		self:RemoveBuildRestriction(categories.SERAPHIM)
		self:RemoveBuildRestriction(categories.CYBRAN)
		oldMAS0001.OnStopBeingBuilt(self,builder,layer)
    end,
}


TypeClass = MAS0001

