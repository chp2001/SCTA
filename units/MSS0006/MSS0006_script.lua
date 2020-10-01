#****************************************************************************
#**
#**
#**  Summary  :  Cybran Long Range Artillery Script
#**
local CLandUnit = import('/lua/cybranunits.lua').CLandUnit


MSS0006 = Class(CLandUnit) {
   OnStopBeingBuilt = function(self, builder, layer)
		ForkThread(self.Delay, self, builder, layer)
		self:Destroy()
	 end,
 
 
	 Delay = function (self, builder, layer)
		 local position = self:GetPosition()
		 local cdrUnit = CreateUnitHPR('armcom', self:GetArmy(), (position.x), (position.y+1), (position.z), 0, 0, 0)  
		 cdrUnit:SetUnSelectable(false)
		 cdrUnit:SetBlockCommandQueue(true)
		 WaitSeconds(3)
		 cdrUnit:SetBlockCommandQueue(false)
	 end,
   
   
   }

TypeClass = MSS0006