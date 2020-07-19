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


MSS0004 = Class(CLandUnit) {

     OnStopBeingBuilt = function(self,builder,layer)
       local position = self:GetPosition()
       local cdrUnit = CreateUnitHPR('ual0001', self:GetArmy(), (position.x), (position.y+1), (position.z), 0, 0, 0)  
	   --self:HideBone(0, true)
	   --self:SetUnSelectable(true)
	   cdrUnit:HideBone(0, true)
	   --cdrUnit:SetUnSelectable(true)
	   cdrUnit:SetBlockCommandQueue(true)
	   self:SetBlockCommandQueue(true)
	   --local currGameTime = GetGameTimeSeconds() 
	   --while currGameTime < 11 do
		--WaitSeconds(0.1)
	   --end
	   cdrUnit:PlayCommanderWarpInEffect()
       self:Destroy()
    end,


    CommanderWarpDelay = function (cdrUnit, delay)
    --cdrUnit:SetBlockCommandQueue(true)
    --WaitSeconds(delay)
    --cdrUnit:PlayCommanderWarpInEffect()
    end,


}

TypeClass = MSS0004

