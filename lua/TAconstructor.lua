local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local Unit = import('/lua/sim/Unit.lua').Unit
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local oldPosition={1,1,1}

TAconstructor = Class(TAWalking) {
	currentState = "closed",
	desiredState = "closed",
    currentTarget = nil,
	desiredTarget = nil,
	order = nil,

	isBuilding = nil,
	isReclaiming = nil,

	pauseTime = 3,

	animating = nil,

	OnStartBuild = function(self, unitBeingBuilt, order)
		self:Open()
		TAWalking.OnStartBuild(self, unitBeingBuilt, order)
	end,

	CreateBuildEffects = function(self, unitBeingBuilt, order)
        TAUtil.CreateTABuildingEffects( self, unitBeingBuilt, self.BuildEffectBones, self.BuildEffectsBag )
	end,
	
	OnStopBuild = function(self, unitBeingBuilt)
		self:Close()
       TAWalking.OnStopBuild(self, unitBeingBuilt)
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
		self.desiredTarget = target
		if (self.currentState == "aimed") then
			self.currentState = "opened"
			self.desiredState = "aimed"
		else
			self.desiredState = "opened"
		end
		self.isBuilding = nil
		---if not self.cloakOn then
		self.isCapturing = true
		self.isReclaiming = true
		if (not self.animating) then
			ForkThread(TAconstructor.AnimationThread, self)
		end
	end,


	OnStopCapture = function(self, target)
		TAconstructor.OnStopCapture(self, target)
		self.isCapturing = nil
		TAconstructor.Conclude(self, target)
	end,
    
    OnFailedCapture = function(self, target)
		TAconstructor.OnFailedCapture(self, target)
		self.isCapturing = nil
		TAconstructor.Conclude(self, target)
    end,

	Conclude = function(self, target)
		TAconstructor.Conclude(self, target)
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