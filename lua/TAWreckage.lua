local Wreckage = import('/lua/Wreckage.lua').Wreckage

local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

TAWreckage = Class(Wreckage) {
	OnCreate = function(self)
        Wreckage.OnCreate(self)
    end,

}
