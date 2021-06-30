#Nuclear Missile Rocket
#CRBLMSSL
#
#Script created by Raevn

local TANuclearProjectile = import('/mods/SCTA-master/lua/TAprojectiles.lua').TANuclearProjectile

EZBMSSL = Class(TANuclearProjectile) {
    OnCreate = function(self)
        TANuclearProjectile.OnCreate(self)
        self.effectEntityPath = '/mods/SCTA-master/effects/entities/TANuke01/TANuke01_proj.bp'
        self:LauncherCallbacks()
    end,

}

TypeClass = EZBMSSL