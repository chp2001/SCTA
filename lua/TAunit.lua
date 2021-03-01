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
		self.FxMovement = TrashBag()
        end,

	OnStopBeingBuilt = function(self,builder,layer)
        ---self:LOGDBG('TAUnit.OnStopBeingBuilt')
		Unit.OnStopBeingBuilt(self,builder,layer)
		self:SetDeathWeaponEnabled(true)
		---self:SetConsumptionActive(true)	
	end,

    TAIntelMotion = function(self, new, old ) 
			while not self.Dead do
            coroutine.yield(11)
            if self:IsUnitState('Moving') and self.TAIntelOn then
                self:SetConsumptionPerSecondEnergy(self:GetBlueprint().Economy.TAConsumptionPerSecondEnergy)
			elseif self.TAIntelOn then
                self:SetConsumptionPerSecondEnergy(self:GetBlueprint().Economy.MaintenanceConsumptionPerSecondEnergy)
            end
		end
    end,


	OnDamage = function(self, instigator, amount, vector, damageType)
		Unit.OnDamage(self, instigator, amount * (self.Pack or 1), vector, damageType)
	end,
	
	OnIntelDisabled = function(self)
		Unit.OnIntelDisabled()
		if EntityCategoryContains(categories.TACLOAK, self) then
		self.TAIntelOn = nil	
		self.CloakOn = nil
		if not self:IsIntelEnabled('Cloak') then
        self:PlayUnitSound('Uncloak')
		self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
		end
	end
    end,

    OnIntelEnabled = function(self)
		Unit.OnIntelEnabled()
		if not IsDestroyed(self) then
		if EntityCategoryContains(categories.TACLOAK, self) then
			if self:IsIntelEnabled('Jammer') then
			self.TAIntelOn = true
			ForkThread(self.TAIntelMotion, self)
			end
			if self:IsIntelEnabled('Cloak') then
			self.CloakOn = true
        	self:PlayUnitSound('Cloak')
			self:SetMesh(self:GetBlueprint().Display.CloakMesh, true)
			ForkThread(self.CloakDetection, self)
			end
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
			if self:IsUnitState('Moving') and self.CloakOn then
                self:SetConsumptionPerSecondEnergy(self:GetBlueprint().Economy.TAConsumptionPerSecondEnergy)
			elseif self.CloakOn then
                self:SetConsumptionPerSecondEnergy(self:GetBlueprint().Economy.MaintenanceConsumptionPerSecondEnergy)
            end
            local dudes = GetUnitsAroundPoint(brain, cat, getpos(self), 4, 'Enemy')
			if self:IsUnitState('Building') and self.CloakOn and not IsDestroyed(self) then
				self:DisableIntel('Cloak')
				self:UpdateConsumptionValues()
                self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
			elseif dudes[1] and self.CloakOn then
                self:DisableIntel('Cloak')
                self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
			elseif not dudes[1] and self.CloakOn then
                self:EnableIntel('Cloak')
				---self:UpdateConsumptionValues()
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
		if bit == 2 then
			self:DisableUnitIntel('ToggleBit2', 'Jammer')
			if self.TAIntelThread then KillThread(self.TAIntelThread) end
			self.TAIntelThread = self:ForkThread(self.TAIntelMotion)	
		end
		Unit.OnScriptBitSet(self, bit)
	end,

	OnScriptBitClear = function(self, bit)
		if bit == 8 then
			if self.CloakThread then
				KillThread(self.CloakThread)
				self.CloakOn = nil
			end
		end
		if bit == 2 then
			if self.TAIntelThread then
				KillThread(self.TAIntelThread)
				self.TAIntelOn = nil
			end
		end
		Unit.OnScriptBitClear(self, bit)
	end,

}
