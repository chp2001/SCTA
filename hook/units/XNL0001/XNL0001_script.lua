local oldXNL0001 = XNL0001
XNL0001 = Class(oldXNL0001) {
    PlayCommanderWarpInEffect = function(self)  -- part of initial dropship animation
        self:SetUnSelectable(false)
        self:SetBusy(true)
        self:SetBlockCommandQueue(true)
        self.PlayCommanderWarpInEffectFlag = true
        self:ForkThread(self.DoMeteorAnim)
    end,

}

TypeClass = XNL0001
