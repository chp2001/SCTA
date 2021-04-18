#
# script for projectile BoneAttached
#
local EmitterProjectile = import('/lua/sim/defaultprojectiles.lua').EmitterProjectile

TANukeShockwave02 = Class(EmitterProjectile) {
    FxTrails = {'/mods/SCTA-master/effects/emitters/ta_missile_hit_03_emit.bp',},
    FxTrailScale = 0.5,
    FxTrailOffset = 0,
}

TypeClass = TANukeShockwave02