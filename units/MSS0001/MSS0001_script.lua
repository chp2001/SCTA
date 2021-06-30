#****************************************************************************
#**
#**  File     :  /cdimage/units/URB5101/URB5101_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  -- 				local terrain = GetTerrainType(xpos, zpos)
#-- 				if terrain.TypeCode >= 220 then
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CLandUnit = import('/lua/cybranunits.lua').CLandUnit


MSS0001 = Class(CLandUnit) {

     OnStopBeingBuilt = function(self, builder, layer)
		SetArmyFactionIndex(self:GetArmy(), 3)
		ForkThread(self.Delay, self, builder, layer)
		self:Destroy()
	 end,
 
 
	 Delay = function (self, builder, layer)
		 local position = self:GetPosition()
		 local cdrUnit = CreateUnitHPR('xsl0001', self:GetArmy(), (position.x), (position.y+1), (position.z), 0, 0, 0)  
		 cdrUnit:HideBone(0, true)
		 cdrUnit:SetUnSelectable(false)
		 cdrUnit:SetBlockCommandQueue(true)
		 WaitSeconds(2)
		 if not IsDestroyed(cdrUnit) then
		 cdrUnit:ForkThread(cdrUnit.PlayCommanderWarpInEffect)
		 end
	end,

}

TypeClass = MSS0001

