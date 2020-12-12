local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local Unit = import('/lua/sim/Unit.lua').Unit
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local oldPosition={1,1,1}

TAconstructor = Class(TAWalking) {
    OnCreate = function(self)
        TAWalking.OnCreate(self) 
    
        self.EffectsBag = {}
        if self:GetBlueprint().General.BuildBones then
            self:SetupBuildBones()
        end

        if self:GetBlueprint().Display.AnimationBuild then
            self.BuildingOpenAnim = self:GetBlueprint().Display.AnimationBuild
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
        self:StopUnitAmbientSound( 'ConstructLoop' )
        TAWalking.OnPaused(self)
        if self.BuildingUnit then
            TAWalking.StopBuildingEffects(self, self:GetUnitBeingBuilt())
        end    
    end,
    
    OnUnpaused = function(self)
        if self.BuildingUnit then
            self:PlayUnitAmbientSound( 'ConstructLoop' )
            TAWalking.StartBuildingEffects(self, self:GetUnitBeingBuilt(), self.UnitBuildOrder)
        end
        TAWalking.OnUnpaused(self)
    end,
    
    OnStartBuild = function(self, unitBeingBuilt, order )
        TAWalking.OnStartBuild(self,unitBeingBuilt, order)
        self:Open()
        self.UnitBeingBuilt = unitBeingBuilt
        self.UnitBuildOrder = order
        self.BuildingUnit = true
        if unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo and order == 'Upgrade' then
            self.Upgrading = true
            self.BuildingUnit = false
        end
    end,

    Open = function(self)
    end,

    OnStopBuild = function(self, unitBeingBuilt)
        self:Close()
        TAWalking.OnStopBuild(self,unitBeingBuilt)
        if self.Upgrading then
            NotifyUpgrade(self,unitBeingBuilt)
            self:Destroy()
        end
        self.UnitBeingBuilt = nil
        self.UnitBuildOrder = nil

        if self.BuildingOpenAnimManip and self.BuildArmManipulator then
            self.StoppedBuilding = true
        elseif self.BuildingOpenAnimManip then
            self.BuildingOpenAnimManip:SetRate(-1)
        end
        self.BuildingUnit = false
    end,

    Close = function(self)
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

        #LOG( 'OnPrepareArmToBuild' )
        if self.BuildingOpenAnimManip then
            self.BuildingOpenAnimManip:SetRate(self:GetBlueprint().Display.AnimationBuildRate or 1)
            if self.BuildArmManipulator then
                self.StoppedBuilding = false
                ForkThread( self.WaitForBuildAnimation, self, true )
            end
        end
    end,

    OnStopBuilderTracking = function(self)
        TAWalking.OnStopBuilderTracking(self)

        if self.StoppedBuilding then
            self.StoppedBuilding = false
            self.BuildArmManipulator:Disable()
            self.BuildingOpenAnimManip:SetRate(-(self:GetBlueprint().Display.AnimationBuildRate or 1))
        end
    end,
    

    CheckBuildRestriction = function(self, target_bp)
        if self:CanBuild(target_bp.BlueprintId) then
            return true
        else
            return false
        end
    end,

	CreateBuildEffects = function(self, unitBeingBuilt, order)
        TAutils.CreateTABuildingEffects( self, unitBeingBuilt, self.BuildEffectBones, self.BuildEffectsBag )
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
        newUnit:SetHealth(nil, newUnit:GetMaxHealth() * ReclaimLeft * 0.5)
    end,
}

TACommander = Class(TAconstructor) {

	OnStartCapture = function(self, target)
		---self:SetCaptureTimeMultiplier(1)
		--self:SetBuildRate(self:GetBlueprint().Economy.BuildRate * 0.6)
		TAconstructor.OnStartCapture(self, target)
		self:SetScriptBit('RULEUTC_CloakToggle', true)
		self:SetAllWeaponsEnabled(false)
	end,


	OnStopCapture = function(self, target)
		TAconstructor.OnStopCapture(self, target)
	end,
    
    OnFailedCapture = function(self, target)
		TAconstructor.OnFailedCapture(self, target)
    end,

	Conclude = function(self, target)
		if self.cloakOn then
		ForkThread(self.CloakDetection, self)
		end
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
            elseif not dudes[1] and self.cloakOn then
                self:EnableIntel('Cloak')
            end
        end
	end,

	DeathThread = function(self)
		local army = self:GetArmy()
		CreateAttachedEmitter( self, 0, army, '/mods/SCTA-master/effects/emitters/COMBOOM_emit.bp'):ScaleEmitter(10)
		TAconstructor.DeathThread(self)
	end,
}