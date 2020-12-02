local oldXNL0001 = XNL0001
XNL0001 = Class(oldXNL0001) {
    OnStopBeingBuilt = function(self, builder, layer)
        oldXNL0001.OnStopBeingBuilt(self, builder, layer)
        self:ForkThread(self.DoMeteorAnim) --should only be used for testing out the drop animation
    end,

}

TypeClass = XNL0001
