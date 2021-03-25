-----------------------------------------------------------------
-- File: lua/modules/ui/game/construction.lua
-- Author: Chris Blackwell / Ted Snook
-- Summary: Construction management UI
-- Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
-----------------------------------------------------------------
local TAStratIconReplacement = StratIconReplacement

function StratIconReplacement(control)
        local TAName = __blueprints[control.Data.id].TAStrategicIconName
        if TAName and DiskGetFileInfo('/textures/ui/icons_strategic/' .. TAName .. '.dds') then
            control.StratIcon:SetTexture('/textures/ui/icons_strategic/' .. TAName .. '.dds')
            LayoutHelpers.SetDimensions(control.StratIcon, control.StratIcon.BitmapWidth(), control.StratIcon.BitmapHeight())
            LayoutHelpers.AtTopIn(control.StratIcon, control.Icon, 1)
            LayoutHelpers.AtRightIn(control.StratIcon, control.Icon, 1)
            LayoutHelpers.ResetBottom(control.StratIcon)
            LayoutHelpers.ResetLeft(control.StratIcon)
            control.StratIcon:SetAlpha(0.8)
        end
    if not TAName then
        TAStratIconReplacement(control)
    end
end