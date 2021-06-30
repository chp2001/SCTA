#Nuclear Missile Rocket
#NUCLEAR_MISSILE
#
#Script created by Raevn

local TANuclearProjectile = import('/mods/SCTA-master/lua/TAprojectiles.lua').TANuclearProjectile

NUCLSC_MISSILE = Class(TANuclearProjectile) {
    OnCreate = function(self)
        TANuclearProjectile.OnCreate(self)
        self.effectEntityPath = '/mods/SCTA-master/effects/entities/TANuke02/TANuke02_proj.bp'
        self:LauncherCallbacks()
    end,
}

TypeClass = NUCLSC_MISSILE