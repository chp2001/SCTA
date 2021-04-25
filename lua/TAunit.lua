#Generic TA unit
local Unit = import('/lua/sim/Unit.lua').Unit
local FireState = import('/lua/game.lua').FireState
local TADeath = import('/mods/SCTA-master/lua/TADeath.lua')
local Wreckage = import('/lua/wreckage.lua')

TAunit = Class(Unit) 
{

    --LOGDBG = function(self, msg)
        --LOG(self._UnitName .. "(" .. self.Sync.id .. "):" .. msg)
   ---end,

	OnCreate = function(self)
        --self._UnitName = bp.General.UnitName
        ---self:LOGDBG('TAUnit.OnCreate')
        Unit.OnCreate(self)
		local aiBrain = self:GetAIBrain()
		if aiBrain.SCTAAI then
			self:SetFireState(FireState.RETURN_FIRE)
			else
			self:SetFireState(FireState.GROUND_FIRE)
			end
		---LOG(self:GetBlueprint().Physics.MotionType)
        end,

	OnStopBeingBuilt = function(self,builder,layer)
        ---self:LOGDBG('TAUnit.OnStopBeingBuilt')
		Unit.OnStopBeingBuilt(self,builder,layer)
		self:SetDeathWeaponEnabled(true)
	end,

	OnDamage = function(self, instigator, amount, vector, damageType)
		Unit.OnDamage(self, instigator, amount * (self.Pack or 1), vector, damageType)
	end,

	OnIntelDisabled = function(self)
		Unit.OnIntelDisabled()
		if self.TACloak and not self:IsIntelEnabled('Cloak') then
			self:PlayUnitSound('Uncloak')
			self.CloakOn = nil
			self:SetMesh(self.Mesh, true)
			return
		elseif self.SpecIntel and (not self:IsIntelEnabled('Jammer') or not self:IsIntelEnabled('RadarStealth')) then
			self.TAIntelOn = nil
			return	
		end
	end,

	OnIntelEnabled = function(self)
		Unit.OnIntelEnabled()
		if not IsDestroyed(self) then
			if self:IsIntelEnabled('Cloak') and self.TACloak then
					self.CloakOn = true
					self:PlayUnitSound('Cloak')
					self:SetMesh(self:GetBlueprint().Display.CloakMeshBlueprint, true)
					ForkThread(self.CloakDetection, self)
					return
			elseif (self:IsIntelEnabled('Jammer') or self:IsIntelEnabled('RadarStealth')) and self.SpecIntel then
					self.TAIntelOn = true
					ForkThread(self.TAIntelMotion, self)
					return
			end
		end
	end,

	TAIntelMotion = function(self) 
		while not self.Dead do
            coroutine.yield(11)
			if self.TAIntelOn and self:IsIdleState() then
                self:SetConsumptionPerSecondEnergy(self.MainCost)
			elseif self.TAIntelOn then
                self:SetConsumptionPerSecondEnergy(self.MainCost * 2)
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
			if self.CloakOn and self:IsUnitState('Building') then
				self:DisableIntel('Cloak')
				self:DisableIntel('CloakField')
				self:UpdateConsumptionValues()
                self:SetMesh(self.Mesh, true)
			elseif dudes[1] and self.CloakOn then
				self:DisableIntel('Cloak')
				self:DisableIntel('CloakField')
				self:SetMesh(self.Mesh, true)
				if self.Structure then
				self.TACloak = nil
				self.CloakOn = nil
				self:SetMaintenanceConsumptionInactive()
				end
			elseif not dudes[1] and self.CloakOn then
				self:EnableIntel('Cloak')
				self:EnableIntel('CloakField')
				self:SetMesh(self:GetBlueprint().Display.CloakMeshBlueprint, true)
				if self:IsIdleState() then
					self:SetConsumptionPerSecondEnergy(self.MainCost)
				else
					self:SetConsumptionPerSecondEnergy(self.MainCost * 3)
				end
			end
		end
	end,

	CreateWreckageProp = function(self, overkillRatio)
		local bp = self:GetBlueprint()

        local wreck = bp.Wreckage.Blueprint
        if not wreck then
            return nil
        end

        local mass = bp.Economy.BuildCostMass * (bp.Wreckage.MassMult or 0)
        local energy = bp.Economy.BuildCostEnergy * (bp.Wreckage.EnergyMult or 0)
        local time = (bp.Wreckage.ReclaimTimeMultiplier or 1)
        local pos = self:GetPosition()
        local layer = self:GetCurrentLayer()

        -- Reduce the mass value of submerged wrecks
        if layer == 'Water' or layer == 'Sub' then
            mass = mass * 0.5
            energy = energy * 0.5
        end

        local halfBuilt = self:GetFractionComplete() < 1

        -- Make sure air / naval wrecks stick to ground / seabottom, unless they're in a factory.
        if not halfBuilt and EntityCategoryContains(categories.NAVAL - categories.STRUCTURE, self) then
            pos[2] = GetTerrainHeight(pos[1], pos[3]) + GetTerrainTypeOffset(pos[1], pos[3])
        end

        local overkillMultiplier = 1 - (overkillRatio or 1)
        mass = mass * overkillMultiplier * self:GetFractionComplete()
        energy = energy * overkillMultiplier * self:GetFractionComplete()
        time = time * overkillMultiplier

        -- Now we adjust the global multiplier. This is used for balance purposes to adjust global reclaim rate.
        local time  = time * 2
		if overkillMultiplier < 0.5 then
		local prop = TADeath.CreateHeap(bp, pos, self:GetOrientation(), mass, energy, time, self.DeathHitBox)
		else
        local prop = Wreckage.CreateWreckage(bp, pos, self:GetOrientation(), mass, energy, time, self.DeathHitBox)

        -- Create some ambient wreckage smoke
        if layer == 'Land' then
            TADeath.CreateTAWreckageEffects(self, prop)
        end

        return prop
		end
	end,

	OnScriptBitSet = function(self, bit)
		if self.SpecIntel and (bit == 2 or bit == 5) then
			--self:SetMaintenanceConsumptionActive()
			--self:DisableUnitIntel('ToggleBit2', 'Jammer')
			--self:DisableUnitIntel('ToggleBit5', 'RadarStealth')
            --self:DisableUnitIntel('ToggleBit5', 'RadarStealthField')
			if self.TAIntelThread then KillThread(self.TAIntelThread) end
			self.TAIntelThread = self:ForkThread(self.TAIntelMotion)	
		end
		if bit == 8 and self.TACloak then
			--self:DisableUnitIntel('ToggleBit8', 'Cloak')
			if self.CloakThread then KillThread(self.CloakThread) end
			self.CloakThread = self:ForkThread(self.CloakDetection)	
		end
		Unit.OnScriptBitSet(self, bit)
	end,

	OnScriptBitClear = function(self, bit)
		if self.SpecIntel and (bit == 2 or bit == 5) then
			--self:SetMaintenanceConsumptionInactive()
			if self.TAIntelThread then
				KillThread(self.TAIntelThread)
				self.TAIntelOn = nil
			end
		end
		if bit == 8 and self.TACloak then
			if self.CloakThread then
				KillThread(self.CloakThread)
				self.CloakOn = nil
			end
		end
		Unit.OnScriptBitClear(self, bit)
	end,
}
