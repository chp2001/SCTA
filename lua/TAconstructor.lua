local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local Unit = import('/lua/sim/Unit.lua').Unit
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local oldPosition={1,1,1}
local EffectUtil = import('/lua/EffectUtilities.lua')
local Util = import('/lua/utilities.lua')
local RandomFloat = Util.GetRandomFloat

TAconstructor = Class(TAWalking) {
    OnCreate = function(self)
        TAWalking.OnCreate(self) 
        local bp = self:GetBlueprint()
        -- Save build effect bones for faster access when creating build effects
        self.BuildEffectBones = bp.General.BuildBones.BuildEffectBones

        self.EffectsBag = {}
        if bp.General.BuildBones then
            self:SetupBuildBones()
        end

        if bp.Display.AnimationBuild then
            self.BuildingOpenAnim = bp.Display.AnimationBuild
        end

        if self.BuildingOpenAnim then
            self.BuildingOpenAnimManip = CreateAnimator(self)
            self.BuildingOpenAnimManip:SetPrecedence(1)
            self.BuildingOpenAnimManip:PlayAnim(self.BuildingOpenAnim, false):SetRate(0)
            if self.BuildArmManipulator then
                self.BuildArmManipulator:Disable()
            end
        end
        self.BuildingUnit = false
        if __blueprints['armmass'] then
            TAutils.updateBuildRestrictions(self)
        end
    end,

    OnPaused = function(self)
        TAWalking.OnPaused(self)
        if self.BuildingUnit then
            TAWalking.StopBuildingEffects(self, self:GetUnitBeingBuilt())
        end    
    end,
    
    OnUnpaused = function(self)
        if self.BuildingUnit then
            TAWalking.StartBuildingEffects(self, self:GetUnitBeingBuilt(), self.UnitBuildOrder)
        end
        TAWalking.OnUnpaused(self)
    end,
    
    OnStartBuild = function(self, unitBeingBuilt, order ) 
        TAWalking.OnStartBuild(self, unitBeingBuilt, order)
        if order == 'Repair' and unitBeingBuilt.WorkItem != self.WorkItem then
			TAWalking.InheritWork(self, unitBeingBuilt)
		end 
        self.UnitBeingBuilt = unitBeingBuilt
        self.UnitBuildOrder = order
        self.BuildingUnit = true
    end,


    OnStopBuild = function(self, unitBeingBuilt)
        TAWalking.OnStopBuild(self,unitBeingBuilt)
        self.UnitBeingBuilt = nil
        self.UnitBuildOrder = nil

        if self.BuildingOpenAnimManip and self.BuildArmManipulator then
            self.StoppedBuilding = true
        elseif self.BuildingOpenAnimManip then
            self.BuildingOpenAnimManip:SetRate(-1)
        end
        self:OnStopBuilderTracking()
        self.BuildingUnit = false
        if __blueprints['armmass'] then
            TAutils.updateBuildRestrictions(self)
        end
    end,

    WaitForBuildAnimation = function(self, enable)
        if self.BuildArmManipulator then
            WaitFor(self.BuildingOpenAnimManip)
            if (enable) then
                self.BuildArmManipulator:Enable()
            end
        end
    end,

    OnPrepareArmToBuild = function(self)
        TAWalking.OnPrepareArmToBuild(self)
        if self.BuildingOpenAnimManip then
            self.BuildingOpenAnimManip:SetRate(self:GetBlueprint().Display.AnimationBuildRate or 1)
            if self.BuildArmManipulator then
                self.StoppedBuilding = false
                ForkThread( self.WaitForBuildAnimation, self, true )
            end
        end       
         if self:IsMoving() then
            self:SetImmobile(true)
            self:ForkThread(function() WaitTicks(1) if not self:BeenDestroyed() then self:SetImmobile(false) end end)
        end
    end,

    OnFailedToBuild = function(self)
        TAWalking.OnFailedToBuild(self)
        self:SetImmobile(false)
    end,

    OnStopBuilderTracking = function(self)
        TAWalking.OnStopBuilderTracking(self)

        if self.StoppedBuilding then
            self.StoppedBuilding = false
            self.BuildArmManipulator:Disable()
            self.BuildingOpenAnimManip:SetRate(-(self:GetBlueprint().Display.AnimationBuildRate or 1))
            self:SetImmobile(false)
        end
    end,
    
    CreateBuildEffects = function( self, unitBeingBuilt, order )
        self.BuildEffectsBag:Add( TAutils.CreateTABuildingEffects( self, unitBeingBuilt, self.BuildEffectBones, self.BuildEffectsBag ))
    end,

    CreateReclaimEffects = function( self, target )
		TAutils.TAReclaimEffects( self, target, self:GetBlueprint().General.BuildBones.BuildEffectBones or {0,}, self.ReclaimEffectsBag )
    end,
    
    CreateReclaimEndEffects = function( self, target )
        EffectUtil.PlayReclaimEndEffects( self, target )
    end,         
    
    OnStopReclaim = function(self, target)
        TAWalking.OnStopReclaim(self, target)
        if self.BuildingOpenAnimManip then
            self.BuildingOpenAnimManip:SetRate(-1)
        end
    end,

    OnStartReclaim = function(self, target)
        TAWalking.OnStartReclaim(self, target)
    end,
}


TANecro = Class(TAconstructor) {
    OnStartReclaim = function(self, target, oldPosition)
        if EntityCategoryContains(categories.NECRO, self) then
            if not target.ReclaimInProgress and not target.NecroingInProgress then
                --LOG('* Necro: OnStartReclaim:  I am a necro! no ReclaimInProgress; starting Necroing')
                target.NecroingInProgress = true
				self.spawnUnit = true
                self.RecBP = target.AssociatedBP
                self.ReclaimLeft = target.ReclaimLeft
                self.RecPosition = target:GetPosition()
            elseif not target.ReclaimInProgress and target.NecroingInProgress then
				--LOG('* Necro: OnStartReclaim:  I am a necro and helping necro')
				self.RecBP = nil
				self.ReclaimLeft = nil
				self.RecPosition = target:GetPosition()
			else
                --LOG('* Necro: OnStartReclaim:  I am a necro and ReclaimInProgress; Stopped!')
				self.RecBP = nil
                self.ReclaimLeft = nil
                self.RecPosition = nil
                IssueStop({self})
                IssueClearCommands({self})
                return
            end
        else
            if not target.NecroingInProgress then
                --LOG('* Necro: OnStartReclaim:  I am engineer, no NecroingInProgress, starting Reclaim')
                target.ReclaimInProgress = true
            else
                --LOG('* Necro: OnStartReclaim:  I am engineer and NecroingInProgress; Stopped!')
                IssueStop({self})
                IssueClearCommands({self})
                return
            end
        end
        TAconstructor.OnStartReclaim(self, target, oldPosition)
    end,

    OnStopReclaim = function(self, target, oldPosition)
        TAconstructor.OnStopReclaim(self, target, oldPosition)
        if not target then
            if self.RecBP and EntityCategoryContains(categories.NECRO, self) and oldPosition ~= self.RecPosition and self.spawnUnit then
                --LOG('* Necro: OnStopReclaim:  I am a necro! and RecBP = true ')
                oldPosition = self.RecPosition
                self:ForkThread( self.RespawnUnit, self.RecBP, self:GetArmy(), self.RecPosition, self.ReclaimLeft )
            else
                --LOG('* Necro: OnStopReclaim: no necro or no RecBP')
            end
        else
            if EntityCategoryContains(categories.NECRO, self) then
                --LOG('* Necro: OnStopReclaim:  Wreck still exist. Removing target data from Necro')
                self.RecBP = nil
                self.ReclaimLeft = nil
                self.RecPosition = nil
            else
                --LOG('* Necro: OnStopReclaim: Wreck still exist. no necro')
            end
        end
    end,

    RespawnUnit = function(self, RecBP, army, pos, ReclaimLeft)
        --LOG('* Necro: RespawnUnit: ReclaimLeft '..ReclaimLeft)
        WaitTicks(3)
        local newUnit = CreateUnitHPR(RecBP, army, pos[1], pos[2], pos[3], 0, 0, 0)
        newUnit:SetHealth(nil, newUnit:GetMaxHealth() * ReclaimLeft * 0.1)
    end,
}

TACommander = Class(TAconstructor) {

    SetAutoOvercharge = function(self, auto)
        local wep = self:GetWeaponByLabel('AutoDGun')
        wep:SetAutoOvercharge(auto)
        self.Sync.AutoOvercharge = auto
    end,

    OnCreate = function(self)
		TAconstructor.OnCreate(self)
        self:SetCapturable(false)
        self:SetWeaponEnabledByLabel('AutoDGun', false)
	end,
    
    CreateCaptureEffects = function( self, target )
		TAutils.TACaptureEffect( self, target, self:GetBlueprint().General.BuildBones.BuildEffectBones or {0,}, self.CaptureEffectsBag )
    end,

	OnStopCapture = function(self, target)
		TAconstructor.OnStopCapture(self, target)
	end,
    
    OnFailedCapture = function(self, target)
		TAconstructor.OnFailedCapture(self, target)
    end,

	DeathThread = function(self)
        local army = self:GetArmy()
        local position = self:GetPosition()
        local PlumeEffectYOffset = 1
        self:CreateProjectile('/effects/entities/UEFNukeEffect02/UEFNukeEffect02_proj.bp',0,PlumeEffectYOffset,0,0,0,1)
		CreateAttachedEmitter( self, 0, army, '/mods/SCTA-master/effects/emitters/COMBOOM_emit.bp'):ScaleEmitter(10)
		TAconstructor.DeathThread(self)
    end,
    
    DoTakeDamage = function(self, instigator, amount, vector, damageType)
        -- Handle incoming OC damage
        if damageType == 'Overcharge' then
            local wep = instigator:GetWeaponByLabel('OverCharge')
            amount = wep:GetBlueprint().Overcharge.commandDamage
        end

        TAconstructor.DoTakeDamage(self, instigator, amount, vector, damageType)
    end,

}

TARealCommander = Class(TACommander) {
    OnStartReclaim = function(self, target)
		TACommander.OnStartReclaim(self, target)
		self:SetScriptBit('RULEUTC_CloakToggle', true)
    end,
    
    DeathThread = function(self)
        local army = self:GetArmy()
        local position = self:GetPosition()
        TACommander.DeathThread(self)
        self:CreateInitialFireballSmokeRing()
        self:ForkThread(self.CreateOuterRingWaveSmokeRing)
        local orientation = RandomFloat(0,2*math.pi)
        CreateDecal(position, orientation, 'Crater01_albedo', '', 'Albedo', 50, 50, 1200, 0, self.Army)
        CreateDecal(position, orientation, 'Crater01_normals', '', 'Normals', 50, 50, 1200, 0, self.Army)
        CreateDecal(position, orientation, 'nuke_scorch_003_albedo', '', 'Albedo', 60, 60, 1200, 0, self.Army)
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

	OnStartCapture = function(self, target)
		TACommander.OnStartCapture(self, target)
		self:SetScriptBit('RULEUTC_CloakToggle', true)
    end,

    OnMotionHorzEventChange = function(self, new, old )
		TACommander.OnMotionHorzEventChange(self, new, old)
        if self.cloakOn then
        if old == 'Stopped' then
			self:SetConsumptionPerSecondEnergy(1000)
			self.motion = 'Moving'
		elseif new == 'Stopped' then
			self:SetConsumptionPerSecondEnergy(self:GetBlueprint().Economy.MaintenanceConsumptionPerSecondEnergy)
			self.motion = 'Stopped'
        end
    end
    end,

    OnStartBuild = function(self, unitBeingBuilt, order )
        TACommander.OnStartBuild(self, unitBeingBuilt, order)
        self:SetScriptBit('RULEUTC_CloakToggle', true)
    end,


    OnKilled = function(self, instigator, type, overkillRatio)
        TACommander.OnKilled(self, instigator, type, overkillRatio)

        if instigator and instigator.Army ~= self.Army then
            local instigatorBrain = ArmyBrains[instigator.Army]

            Sync.EnforceRating = true
            WARN('ACU kill detected. Rating for ranked games is now enforced.')

            if IsAlly(self.Army, instigator.Army) and not ((type == 'DeathExplosion' or type == 'Nuke' or type == 'Deathnuke') and not instigator.SelfDestructed) then
                WARN('Teamkill detected')
                Sync.Teamkill = {killTime = GetGameTimeSeconds(), instigator = instigator.Army, victim = self.Army}
            else
                ForkThread(function()
                    instigatorBrain:ReportScore()
                end)
            end
        end
        ArmyBrains[self.Army].CommanderKilledBy = (instigator or self).Army
    end,
    
    DoTakeDamage = function(self, instigator, amount, vector, damageType)

        TACommander.DoTakeDamage(self, instigator, amount, vector, damageType)
        local aiBrain = self:GetAIBrain()
        if aiBrain then
            aiBrain:OnPlayCommanderUnderAttackVO()
        end

        if self:GetHealth() < ArmyBrains[self.Army]:GetUnitStat(self.UnitId, "lowest_health") then
            ArmyBrains[self.Army]:SetUnitStat(self.UnitId, "lowest_health", self:GetHealth())
        end
    end,
}