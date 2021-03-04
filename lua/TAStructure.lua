#Generic TA unit
local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local scenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local Game = import('/lua/game.lua')
local util = import('/lua/utilities.lua')

TAStructure = Class(TAunit) 
{
	LandBuiltHiddenBones = {'Floatation'},
	MinConsumptionPerSecondEnergy = 1,
    MinWeaponRequiresEnergy = 0,
	
	DoTakeDamage = function(self, instigator, amount, vector, damageType)
	    -- Handle incoming OC damage
        if damageType == 'Overcharge' then
            local wep = instigator:GetWeaponByLabel('OverCharge')
            amount = wep:GetBlueprint().Overcharge.structureDamage
        end
        TAunit.DoTakeDamage(self, instigator, amount, vector, damageType)
    end,

	OnStopBeingBuilt = function(self,builder,layer)
        TAunit.OnStopBeingBuilt(self,builder,layer)
        self:SetMaintenanceConsumptionActive()
    end,

	OnPaused = function(self)
        TAunit.OnPaused(self)
		self:UpdateConsumptionValues()
    end,

    OnUnpaused = function(self)
        TAunit.OnUnpaused(self)
		self:UpdateConsumptionValues()
    end,

	OnStopBuild = function(self, unitBeingBuilt, order)
		TAunit.OnStopBuild(self, unitBeingBuilt, order)
		if unitBeingBuilt:GetFractionComplete() == 1 and unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
			NotifyUpgrade(self, unitBeingBuilt)
			self:Destroy()
		end
	end,
	
	Fold = function(self)
		self.Pack = self:GetBlueprint().Defense.DamageModifier
	end,
	
	Unfold = function(self)
		self.Pack = nil
	end,

}

TAPop = Class(TAStructure) {
	Fold = function(self)
		TAStructure.Fold(self)
		self:EnableIntel('RadarStealth')
	end,

}

TAMass = Class(TAStructure) {
    OnCreate = function(self)
        TAStructure.OnCreate(self)
        local markers = scenarioUtils.GetMarkers()
        local unitPosition = self:GetPosition()

        for k, v in pairs(markers) do
            if(v.type == 'MASS') then
                local massPosition = v.position
                if( (massPosition[1] < unitPosition[1] + 1) and (massPosition[1] > unitPosition[1] - 1) and
                    (massPosition[2] < unitPosition[2] + 1) and (massPosition[2] > unitPosition[2] - 1) and
                    (massPosition[3] < unitPosition[3] + 1) and (massPosition[3] > unitPosition[3] - 1)) then
                    self:SetProductionPerSecondMass(self:GetProductionPerSecondMass() * (v.amount / 100))
                    break
                end
            end
        end
    end,

    OnStartBuild = function(self, unitbuilding, order)
        TAStructure.OnStartBuild(self, unitbuilding, order)
        self:AddCommandCap('RULEUCC_Stop')
    end,

    OnStopBuild = function(self, unitbuilding, order)
        TAStructure.OnStopBuild(self, unitbuilding, order)
        self:RemoveCommandCap('RULEUCC_Stop') 
    end,
	}

TACloser = Class(TAStructure) {
	OnStopBeingBuilt = function(self,builder,layer)
		TAStructure.OnStopBeingBuilt(self,builder,layer)
		closeDueToDamage = nil,
		ChangeState(self, self.OpeningState)
	end,
}	
	
TACKFusion = Class(TAStructure) {
		OnIntelDisabled = function(self)
			TAStructure.OnIntelDisabled()
			if not self:IsIntelEnabled('Cloak') then
			self.CloakOn = nil
			self:PlayUnitSound('Uncloak')
			self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
			end
		end,
	
		OnIntelEnabled = function(self)
			TAStructure.OnIntelEnabled()
			if not IsDestroyed(self) then
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
				local dudes = GetUnitsAroundPoint(brain, cat, getpos(self), 4, 'Enemy')
				if dudes[1] and self.CloakOn then
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
			TAStructure.OnScriptBitSet(self, bit)
		end,
	
		OnScriptBitClear = function(self, bit)
			if bit == 8 then
				if self.CloakThread then
					KillThread(self.CloakThread)
					self.CloakOn = nil
				end
			end
			TAStructure.OnScriptBitClear(self, bit)
		end,
}

TAMine = Class(TACKFusion) {

	OnKilled = function(self, instigator, type, overkillRatio)
		if self.unit.attacked then
			instigator = self
		end
		TACKFusion.OnKilled(self, instigator, type, overkillRatio)
		
	end,
	
	OnStopBeingBuilt = function(self,builder,layer)
		TACKFusion.OnStopBeingBuilt(self,builder,layer)
		self:SetScriptBit('RULEUTC_CloakToggle', false)
		self:RequestRefreshUI()
	end,

}
