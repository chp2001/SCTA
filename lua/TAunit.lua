#Generic TA unit
local Unit = import('/lua/sim/Unit.lua').Unit
local FireState = import('/lua/game.lua').FireState
local explosion = import('/lua/defaultexplosions.lua')
local scenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local Game = import('/lua/game.lua')
local util = import('/lua/utilities.lua')

TAunit = Class(Unit) 
{

    --LOGDBG = function(self, msg)
        --LOG(self._UnitName .. "(" .. self.Sync.id .. "):" .. msg)
   ---end,

	OnCreate = function(self)
		local bp = self:GetBlueprint()
        --self._UnitName = bp.General.UnitName
        ---self:LOGDBG('TAUnit.OnCreate')
        Unit.OnCreate(self)
		self:SetFireState(FireState.GROUND_FIRE)
		self:HideFlares()
		self.FxMovement = TrashBag()
        end,

	OnStopBeingBuilt = function(self,builder,layer)
        ---self:LOGDBG('TAUnit.OnStopBeingBuilt')
		Unit.OnStopBeingBuilt(self,builder,layer)
		self:SetDeathWeaponEnabled(true)
		self:SetConsumptionActive(true)	
		ForkThread(self.IdleEffects, self)
	end,

	OnMotionHorzEventChange = function(self, new, old )
		local bp = self:GetBlueprint()
		Unit.OnMotionHorzEventChange(self, new, old )
	if (new == 'Stopped') and bp.Display.MovementEffects.TAMovement then
			ForkThread(self.IdleEffects, self)
			for k,v in self.FxMovement do
				v:Destroy()
			end
		end
	end,

	MovementEffects = function(self, EffectsBag, TypeSuffix)
		---self:LOGDBG('TAUnit.MovementEffects')
		---Unit.MovementEffects(self, EffectsBag, TypeSuffix)
		local bp = self:GetBlueprint()
		if not IsDestroyed(self) and bp.Display.MovementEffects.TAMovement then
			for k, v in bp.Display.MovementEffects.TAMovement.Bones do
				self.FxMovement:Add(CreateAttachedEmitter(self, v, self:GetArmy(), bp.Display.MovementEffects.TAMovement.Emitter ):ScaleEmitter(bp.Display.MovementEffects.TAMovement.Scale))
			end
		end
	end,

	IdleEffects = function(self)
        ---self:LOGDBG('TAUnit.IdleEffects')
		local bp = self:GetBlueprint()
		if not IsDestroyed(self) and not self:IsMoving() and bp.Display.IdleEffects then
			for k, v in bp.Display.IdleEffects.Bones do
				self.FxMovement:Add(CreateAttachedEmitter(self, v, self:GetArmy(), bp.Display.IdleEffects.Emitter ):ScaleEmitter(bp.Display.IdleEffects.Scale))
			end
		end
	end,

	OnDamage = function(self, instigator, amount, vector, damageType)
		Unit.OnDamage(self, instigator, amount * (self.Pack or 1), vector, damageType)
	end,
	
	OnIntelDisabled = function(self)
		Unit.OnIntelDisabled()
		if EntityCategoryContains(categories.TACLOAK, self) then
		self.cloakOn = nil
        if not self:IsIntelEnabled('Cloak') then
        self:PlayUnitSound('Uncloak')
		self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
		end
	end
    end,

    OnIntelEnabled = function(self)
		Unit.OnIntelEnabled()
			if EntityCategoryContains(categories.TACLOAK, self) then
       	 	if self:IsIntelEnabled('Cloak') then
            self.cloakOn = true
        	self:PlayUnitSound('Cloak')
			self:SetMesh(self:GetBlueprint().Display.CloakMesh, true)
			ForkThread(self.CloakDetection, self)
        --end
		end
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
                self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
            elseif not dudes[1] and self.cloakOn then
                self:EnableIntel('Cloak')
                self:SetMesh(self:GetBlueprint().Display.CloakMesh, true)
            end
        end
    end,

	OnScriptBitSet = function(self, bit)
		if bit == 8 then
			self:DisableUnitIntel('ToggleBit8', 'Cloak')
			if self.CloakThread then KillThread(self.CloakThread) end
			self.CloakThread = self:ForkThread(self.CloakDetection)	
		end
		Unit.OnScriptBitSet(self, bit)
	end,

	OnScriptBitClear = function(self, bit)
		if bit == 8 then
			if self.CloakThread then
				KillThread(self.CloakThread)
				self.cloakOn = nil
			end
		end
		Unit.OnScriptBitClear(self, bit)
	end,

    HideFlares = function(self, bp)
        ---self:LOGDBG('TAUnit.HideFlares')
        if not bp then bp = self:GetBlueprint().Weapon end
        if bp then
            for i, weapon in bp do
                if weapon.RackBones then
                    for j, rack in weapon.RackBones do
                        if not rack.VisibleMuzzle then
                            if rack.MuzzleBones[1] and not rack.MuzzleBones[2] and self:IsValidBone(rack.MuzzleBones[1]) then
                                self:HideBone(rack.MuzzleBones[1], true)
                            elseif rack.MuzzleBones[2] then
                                for mi, muzzle in rack.MuzzleBones do
                                    if self:IsValidBone(muzzle) then
                                        self:HideBone(muzzle, true)
                                    end
                                end
                            end    
                        end
                    end
                end
            end
        end
    end,

}
