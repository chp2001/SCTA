-----------------------------------------------------------------------------------------------
-- File     :  /effects/Entities/UEFNukeEffectController01/UEFNukeEffectController01_script.lua
-- Author(s):  Gordon Duclos
-- Summary  :  Nuclear explosion script
-- Copyright © 2005,2006 Gas Powered Games, Inc.  All rights reserved.
-----------------------------------------------------------------------------------------------
local NullShell = import('/lua/sim/defaultprojectiles.lua').NullShell
local EffectTemplate = import('/lua/EffectTemplates.lua')
local Util = import('/lua/utilities.lua')
local RandomFloat = Util.GetRandomFloat

TANuke02 = Class(NullShell) {
    EffectThread = function(self)
        local position = self:GetPosition()

        -- Create full-screen glow flash
        CreateLightParticle(self, -1, self.Army, 35, 4, 'glow_02', 'ramp_red_02')
        WaitSeconds(0.25)
        CreateLightParticle(self, -1, self.Army, 80, 20, 'glow_03', 'ramp_fire_06')

        -- Create initial fireball dome effect
        --local FireballDomeYOffset = -5
        --self:CreateProjectile('/effects/entities/TANukeEffect01/TANukeEffect01_proj.bp',0,FireballDomeYOffset,0,0,0,1)

        -- Create projectile that controls plume effects
        local PlumeEffectYOffset = 1
        self:CreateProjectile('/mods/SCTA-master/effects/entities/TANukeEffect02/TANukeEffect02_proj.bp',0,PlumeEffectYOffset,0,0,0,1)

    
        CreateEmitterAtEntity(self, self.Army, '/mods/SCTA-master/effects/emitters/COMBOOM_emit.bp')
        

        --self:CreateInitialFireballSmokeRing()
        self:ForkThread(self.CreateOuterRingWaveSmokeRing)
        --self:ForkThread(self.CreateHeadConvectionSpinners)
        --self:ForkThread(self.CreateFlavorPlumes)

        WaitSeconds(0.55)

        CreateLightParticle(self, -1, self.Army, 300, 250, 'glow_03', 'ramp_nuke_04')
      
        -- Create ground decals
        local orientation = RandomFloat(0,2*math.pi)
        CreateDecal(position, orientation, 'Crater01_albedo', '', 'Albedo', 50, 50, 1200, 0, self.Army)
        CreateDecal(position, orientation, 'Crater01_normals', '', 'Normals', 50, 50, 1200, 0, self.Army)
        CreateDecal(position, orientation, 'nuke_scorch_003_albedo', '', 'Albedo', 60, 60, 1200, 0, self.Army)

        WaitSeconds(8.9)
        self:CreateGroundPlumeConvectionEffects(self.Army)
    end,

    CreateInitialFireballSmokeRing = function(self)
        local sides = 12
        local angle = (2*math.pi) / sides
        local velocity = 5
        local OffsetMod = 8

        for i = 0, (sides-1) do
            local X = math.sin(i*angle)
            local Z = math.cos(i*angle)
            self:CreateProjectile('/effects/entities/UEFNukeShockwave01/UEFNukeShockwave01_proj.bp', X * OffsetMod , 1.5, Z * OffsetMod, X, 0, Z)
                :SetVelocity(velocity):SetAcceleration(-0.5)
        end
    end,

    CreateOuterRingWaveSmokeRing = function(self)
        local sides = 32
        local angle = (2*math.pi) / sides
        local velocity = 7
        local OffsetMod = 8
        local projectiles = {}

        for i = 0, (sides-1) do
            local X = math.sin(i*angle)
            local Z = math.cos(i*angle)
            local proj =  self:CreateProjectile('/effects/entities/UEFNukeShockwave02/UEFNukeShockwave02_proj.bp', X * OffsetMod , 2.5, Z * OffsetMod, X, 0, Z)
                :SetVelocity(velocity)
            table.insert(projectiles, proj)
        end

        WaitSeconds(3)

        -- Slow projectiles down to normal speed
        for k, v in projectiles do
            v:SetAcceleration(-0.45)
        end
    end,

    CreateFlavorPlumes = function(self)
        local numProjectiles = 8
        local angle = (2*math.pi) / numProjectiles
        local angleInitial = RandomFloat(0, angle)
        local angleVariation = angle * 0.75
        local projectiles = {}

        local xVec = 0
        local yVec = 0
        local zVec = 0
        local velocity = 0

        -- yVec -0.2, requires 2 initial velocity to start
        -- yVec 0.3, requires 3 initial velocity to start
        -- yVec 1.8, requires 8.5 initial velocity to start

        -- Launch projectiles at semi-random angles away from the sphere, with enough
        -- initial velocity to escape sphere core
        for i = 0, (numProjectiles -1) do
            xVec = math.sin(angleInitial + (i*angle) + RandomFloat(-angleVariation, angleVariation))
            yVec = RandomFloat(0.2, 1)
            zVec = math.cos(angleInitial + (i*angle) + RandomFloat(-angleVariation, angleVariation))
            velocity = 3.4 + (yVec * RandomFloat(2,5))
            table.insert(projectiles, self:CreateProjectile('/effects/entities/UEFNukeFlavorPlume01/UEFNukeFlavorPlume01_proj.bp', 0, 0, 0, xVec, yVec, zVec):SetVelocity(velocity))
        end

        WaitSeconds(3)

        -- Slow projectiles down to normal speed
        for k, v in projectiles do
            v:SetVelocity(2):SetBallisticAcceleration(-0.15)
        end
    end,

    CreateHeadConvectionSpinners = function(self)
        local sides = 10
        local angle = (2*math.pi) / sides
        local HeightOffset = -5
        local velocity = 1
        local OffsetMod = 10
        local projectiles = {}

        for i = 0, (sides-1) do
            local x = math.sin(i*angle) * OffsetMod
            local z = math.cos(i*angle) * OffsetMod
            local proj = self:CreateProjectile('/effects/entities/UEFNukeEffect03/UEFNukeEffect03_proj.bp', x, HeightOffset, z, x, 0, z)
                :SetVelocity(velocity)
            table.insert(projectiles, proj)
        end

        WaitSeconds(1)
        for i = 0, (sides-1) do
            local x = math.sin(i*angle)
            local z = math.cos(i*angle)
            local proj = projectiles[i+1]
            proj:SetVelocityAlign(false)
            proj:SetOrientation(OrientFromDir(Util.Cross(Vector(x,0,z), Vector(0,1,0))),true)
            proj:SetVelocity(0,3,0)
            proj:SetBallisticAcceleration(-0.05)
        end
    end,

    CreateGroundPlumeConvectionEffects = function(self,army)
        CreateEmitterAtEntity(self, army, '/mods/SCTA-master/effects/emitters/COMBOOM_emit.bp'):ScaleEmitter(10)

        local sides = 10
        local angle = (2*math.pi) / sides
        local inner_lower_limit = 2
        local outer_lower_limit = 2
        local outer_upper_limit = 2

        local inner_lower_height = 1
        local inner_upper_height = 3
        local outer_lower_height = 2
        local outer_upper_height = 3

        sides = 8
        angle = (2*math.pi) / sides
        for i = 0, (sides-1) do
            local magnitude = RandomFloat(outer_lower_limit, outer_upper_limit)
            local x = math.sin(i*angle+RandomFloat(-angle/2, angle/4)) * magnitude
            local z = math.cos(i*angle+RandomFloat(-angle/2, angle/4)) * magnitude
            local velocity = RandomFloat(1, 3) * 3
            self:CreateProjectile('/effects/entities/UEFNukeEffect05/UEFNukeEffect05_proj.bp', x, RandomFloat(outer_lower_height, outer_upper_height), z, x, 0, z)
                :SetVelocity(x * velocity, 0, z * velocity)
        end
    end,
}

TypeClass = TANuke02
