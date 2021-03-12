local taXNL0001 = XNL0001
XNL0001 = Class(taXNL0001) {
    PlayCommanderWarpInEffect = function(self)  -- part of initial dropship animation
        self:SetCustomName( ArmyBrains[self:GetArmy()].Nickname )
        self:SetUnSelectable(false)
        self:SetBlockCommandQueue(true)
        self.PlayCommanderWarpInEffectFlag = true
        self:ForkThread(self.DoMeteorAnim)
    end,

}

TypeClass = XNL0001
