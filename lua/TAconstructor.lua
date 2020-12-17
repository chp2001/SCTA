local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local Unit = import('/lua/sim/Unit.lua').Unit
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local oldPosition={1,1,1}
local EffectUtil = import('/lua/EffectUtilities.lua')

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
        TAWalking.OnStartBuild(self,unitBeingBuilt, order)
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

	CreateBuildEffects = function(self, unitBeingBuilt, order)
        TAutils.CreateTABuildingEffects( self, unitBeingBuilt, self.BuildEffectBones, self.BuildEffectsBag )
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
        newUnit:SetHealth(nil, newUnit:GetMaxHealth() * ReclaimLeft * 0.75)
    end,
}

TACommander = Class(TAconstructor) {

    OnCreate = function(self)
		TAconstructor.OnCreate(self)
		self:SetCapturable(false)
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
		CreateAttachedEmitter( self, 0, army, '/mods/SCTA-master/effects/emitters/COMBOOM_emit.bp'):ScaleEmitter(5)
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

	OnStartCapture = function(self, target)
		TACommander.OnStartCapture(self, target)
		self:SetScriptBit('RULEUTC_CloakToggle', true)
    end,

    OnMotionHorzEventChange = function(self, new, old )
		TACommander.OnMotionHorzEventChange(self, new, old)
		if old == 'Stopped' then
			self:SetConsumptionPerSecondEnergy(1000)
			self.motion = 'Moving'
		elseif new == 'Stopped' then
			self:SetConsumptionPerSecondEnergy(200)
			self.motion = 'Stopped'
		end
	end,

	OnIntelDisabled = function(self)
		self.cloakOn = nil
		self:DisableIntel('Cloak')
        self:SetIntelRadius('Omni', 10)
        self:PlayUnitSound('Uncloak')
		self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
	end,

	OnIntelEnabled = function(self)
		--self:EnableIntel('Cloak')
		if self.motion == 'Moving' then
			self:SetConsumptionPerSecondEnergy(1000)
		end
        self:SetIntelRadius('Omni', self:GetBlueprint().Intel.OmniRadius)
		self.cloakOn = true
        	self:PlayUnitSound('Cloak')
			self:SetMesh(self:GetBlueprint().Display.CloakMesh, true)
		ForkThread(self.CloakDetection, self)
		--end
	end,

    OnKilled = function(self, instigator, type, overkillRatio)
        TACommander.OnKilled(self, instigator, type, overkillRatio)

        -- If there is a killer, and it's not me
        if instigator and instigator.Army ~= self.Army then
            local instigatorBrain = ArmyBrains[instigator.Army]

            Sync.EnforceRating = true
            WARN('ACU kill detected. Rating for ranked games is now enforced.')

            -- If we are teamkilled, filter out death explostions of allied units that were not coused by player's self destruct order
            -- Damage types:
            --     'DeathExplosion' - when normal unit is killed
            --     'Nuke' - when Paragon is killed
            --     'Deathnuke' - when ACU is killed
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

    CloakDetection = function(self)
        local GetUnitsAroundPoint = moho.aibrain_methods.GetUnitsAroundPoint
        local brain = moho.entity_methods.GetAIBrain(self)
        local cat = categories.SELECTABLE * categories.MOBILE
        local getpos = moho.entity_methods.GetPosition
        while not self.Dead do
            coroutine.yield(11)
            local dudes = GetUnitsAroundPoint(brain, cat, getpos(self), 4, 'Enemy')
            if dudes[1] and self.cloakOn then
                self:DisableIntel('Cloak')
                self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
            elseif not dudes[1] and self.cloakOn then
                self:EnableIntel('Cloak')
                self:SetMesh(self:GetBlueprint().Display.CloakMesh, true)
            end
        end
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