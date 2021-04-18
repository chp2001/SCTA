#
# script for projectile BoneAttached
#
local EmitterProjectile = import('/lua/sim/defaultprojectiles.lua').EmitterProjectile

TAEMPNukeShockwave02 = Class(EmitterProjectile) {
    FxTrails = {'/mods/SCTA-master/effects/emitters/LIGHTNING_emit.bp',},
    FxTrailScale = 0.5,
    FxTrailOffset = 0,
}

TypeClass = TAEMPNukeShockwave02