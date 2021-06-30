#Nuclear Missile Rocket
#CRBLMSSL
#
#Script created by Raevn

local TANuclearProjectile = import('/mods/SCTA-master/lua/TAprojectiles.lua').TANuclearProjectile

TANUMSSL = Class(TANuclearProjectile) {
    OnCreate = function(self)
        TANuclearProjectile.OnCreate(self)
        self.effectEntityPath = '/mods/SCTA-master/effects/entities/TANuke02/TANuke02_proj.bp'
        self:LauncherCallbacks()
    end,
}

TypeClass = TANUMSSL