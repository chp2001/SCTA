#ARM Merl Rocket
#ARMTRUCK_ROCKET
#
#Script created by Raevn

local TAMissileProjectile = import('/mods/SCTA-master/lua/TAprojectiles.lua').TAMissileProjectile

BHRK_ROCKET = Class(TAMissileProjectile) {
    TrackingThread = function(self)
        self:TrackTarget(false)
        WaitTicks(0.1)
        self:TrackTarget(true)
        WaitSeconds(self.TrackTime)
        self:TrackTarget(false)
    end,
}

TypeClass = BHRK_ROCKET