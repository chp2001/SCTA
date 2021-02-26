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
	 cdrUnit:HideBone(0, true)
	 cdrUnit:SetUnSelectable(false)
	 cdrUnit:SetBlockCommandQueue(true)
	 WaitSeconds(2)
	 cdrUnit:ForkThread(cdrUnit.PlayCommanderWarpInEffect)
 end,
 
   }

TypeClass = MSS0006