-----------------------------------------------------------------
-- File     :  /lua/defaultunits.lua
-- Author(s):  John Comes, Gordon Duclos
-- Summary  :  Default definitions of units
-- Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
local oldtaACUUnit = ACUUnit
ACUUnit = Class(oldtaACUUnit) {
    PlayCommanderWarpInEffect = function(self)
        self:SetCustomName( ArmyBrains[self:GetArmy()].Nickname )
        self:SetUnSelectable(false)
        self:SetBlockCommandQueue(true)
        WaitSeconds(2)
        self:ForkThread(self.WarpInEffectThread)
    end,
}