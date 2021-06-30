-----------------------------------------------------------------
-- File     :  /lua/defaultunits.lua
-- Author(s):  John Comes, Gordon Duclos
-- Summary  :  Default definitions of units
-- Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
local oldtaACUUnit = ACUUnit
ACUUnit = Class(oldtaACUUnit) {
    PlayCommanderWarpInEffect = function(self, bones)
        self:SetCustomName( ArmyBrains[self:GetArmy()].Nickname )
        self:SetUnSelectable(false)
        self:SetBlockCommandQueue(true)
        WaitSeconds(2)
        self:ForkThread(self.WarpInEffectThread, bones)
    end,

    WarpInEffectThread = function(self, bones)
        oldtaACUUnit.WarpInEffectThread(self, bones)
        local rotateOpt = ScenarioInfo.Options['RotateACU']
        if not rotateOpt or rotateOpt == 'On' then
            self:RotateTowardsMid()
        elseif rotateOpt == 'Marker' then
            local marker = GetMarker(strArmy) or {}
            if marker['orientation'] then
                local o = EulerToQuaternion(unpack(marker['orientation']))
                self:SetOrientation(o, true)
            end
            end
        end,
}