#Nuclear Missile Rocket
#CRBLMSSL
#
#Script created by Raevn

local TANuclearProjectile = import('/mods/SCTA-master/lua/TAProjectiles.lua').TANuclearProjectile

TASMSSL = Class(TANuclearProjectile) {
    
    InitialEffects = {'/effects/emitters/nuke_munition_launch_trail_02_emit.bp',},
    LaunchEffects = {
        '/effects/emitters/nuke_munition_launch_trail_03_emit.bp',
        '/effects/emitters/nuke_munition_launch_trail_05_emit.bp',
        '/effects/emitters/nuke_munition_launch_trail_07_emit.bp',
    },
    ThrustEffects = {
        '/effects/emitters/nuke_munition_launch_trail_04_emit.bp',
        '/effects/emitters/nuke_munition_launch_trail_06_emit.bp',
    },

    OnCreate = function(self)
        TANuclearProjectile.OnCreate(self)
        self.effectEntityPath = '/effects/Entities/UEFNukeEffectController01/UEFNukeEffectController01_proj.bp'
        self:LauncherCallbacks()
    end,
}

TypeClass = TASMSSL