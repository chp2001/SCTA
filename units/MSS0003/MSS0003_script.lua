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


MSS0003 = Class(CLandUnit) {

	OnStopBeingBuilt = function(self, builder, layer)
		ForkThread(self.Delay, self, builder, layer)
		self:Destroy()
	 end,
 
 
	 Delay = function (self, builder, layer)
		 local position = self:GetPosition()
		 local cdrUnit = CreateUnitHPR('uel0001', self:GetArmy(), (position.x), (position.y+1), (position.z), 0, 0, 0)  
		 cdrUnit:SetUnSelectable(false)
		 cdrUnit:SetBlockCommandQueue(true)
		 WaitSeconds(3)
		 cdrUnit:SetBlockCommandQueue(false)
	 end,
 



}

TypeClass = MSS0003

