local Prop = import('/lua/sim/Prop.lua').Prop

local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

TAWreckage = Class(Prop) {
	OnCreate = function(self)
        Prop.OnCreate(self)
        self.IsWreckage = true
        self.OrientationCache = self:GetOrientation()
    end,

}
