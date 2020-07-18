#****************************************************************************
#**
#**
#**  Summary  :  Cybran Long Range Artillery Script
#**
local CLandUnit = import('/lua/cybranunits.lua').CLandUnit


MSS0001 = Class(CLandUnit) {
     OnStopBeingBuilt = function(self,builder,layer)
       local position = self:GetPosition()
       local cdrUnit = CreateUnitHPR('xsl0001', self:GetArmy(), (position.x), (position.y+1), (position.z), 0, 0, 0)  
	--cdrUnit:HideBone(0, true)
        --ForkThread(CommanderWarpDelay, cdrUnit, 3)
        self:Destroy()
    end,


    CommanderWarpDelay = function (cdrUnit, delay)
	WaitSeconds(delay)
	cdrUnit:PlayCommanderWarpInEffect()
    end,


}

TypeClass = MSS0001