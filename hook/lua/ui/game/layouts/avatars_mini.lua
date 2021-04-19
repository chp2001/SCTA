function LayoutAvatars()
    local controls = import('/lua/ui/game/avatars.lua').controls
    
    local rightOffset, topOffset, space = 14, 14, -5
    
    local prevControl = false
    local height = 0
    for _, control in controls.avatars do
        if prevControl then
            LayoutHelpers.AnchorToBottom(control, prevControl, space)
            --control.Top:Set(function() return prevControl.Bottom() + space end)
            LayoutHelpers.AtRightIn(control, prevControl)
            height = height + (control.Bottom() - prevControl.Bottom())
        else
            LayoutHelpers.AtRightTopIn(control, controls.avatarGroup, rightOffset, topOffset)
            height = control.Height()
        end
        prevControl = control
    end
    if controls.idleEngineers then
        if prevControl then
            controls.idleEngineers.prevControl = prevControl
            LayoutHelpers.AnchorToBottom(controls.idleEngineers, controls.idleEngineers.prevControl, space)
            LayoutHelpers.AtRightIn(controls.idleEngineers, controls.idleEngineers.prevControl)
            height = height + (controls.idleEngineers.Bottom() - controls.idleEngineers.prevControl.Bottom())
        else
            LayoutHelpers.AtRightTopIn(controls.idleEngineers, controls.avatarGroup, rightOffset, topOffset)
            height = controls.idleEngineers.Height()
        end
        prevControl = controls.idleEngineers
    end
    if controls.idleFieldEngineers then
        if prevControl then
            controls.idleFieldEngineers.prevControl = prevControl
            LayoutHelpers.AnchorToBottom(controls.idleFieldEngineers, controls.idleFieldEngineers.prevControl, space)
            LayoutHelpers.AtRightIn(controls.idleFieldEngineers, controls.idleFieldEngineers.prevControl)
            height = height + (controls.idleFieldEngineers.Bottom() - controls.idleFieldEngineers.prevControl.Bottom())
        else
            LayoutHelpers.AtRightTopIn(controls.idleFieldEngineers, controls.avatarGroup, rightOffset, topOffset)
            height = controls.idleFieldEngineers.Height()
        end
        prevControl = controls.idleFieldEngineers
    end
    if controls.idleTerrainEngineers then
        if prevControl then
            controls.idleTerrainEngineers.prevControl = prevControl
            LayoutHelpers.AnchorToBottom(controls.idleTerrainEngineers, controls.idleTerrainEngineers.prevControl, space)
            LayoutHelpers.AtRightIn(controls.idleTerrainEngineers, controls.idleTerrainEngineers.prevControl)
            height = height + (controls.idleTerrainEngineers.Bottom() - controls.idleTerrainEngineers.prevControl.Bottom())
        else
            LayoutHelpers.AtRightTopIn(controls.idleTerrainEngineers, controls.avatarGroup, rightOffset, topOffset)
            height = controls.idleTerrainEngineers.Height()
        end
        prevControl = controls.idleTerrainEngineers
    end    
    if controls.idleFactories then
        if prevControl then
            controls.idleFactories.prevControl = prevControl
            LayoutHelpers.AnchorToBottom(controls.idleFactories, controls.idleFactories.prevControl, space)
            LayoutHelpers.AtRightIn(controls.idleFactories, controls.idleFactories.prevControl)
            height = height + (controls.idleFactories.Bottom() - controls.idleFactories.prevControl.Bottom())
        else
            LayoutHelpers.AtRightTopIn(controls.idleFactories, controls.avatarGroup, rightOffset, topOffset)
            height = controls.idleFactories.Height()
        end
    end
    
    controls.avatarGroup.Height:Set(function() return height - LayoutHelpers.ScaleNumber(5) end)
end