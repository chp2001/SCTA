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
		if __blueprints['armgant'] then
            local aiBrain = GetArmyBrain(self.Army)
        	if EntityCategoryContains(categories.DEVELOPMENT, self) then
            local buildRestrictionVictims = aiBrain:GetListOfUnits(categories.FACTORY + categories.ENGINEER, false)
            for id, unit in buildRestrictionVictims do    
        	TAutils.updateBuildRestrictions(unit)
        	end
        end
    end
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
		if EntityCategoryContains(categories.TARGETING, self) and (self:IsIntelEnabled('Radar') or self:IsIntelEnabled('Sonar')) then
		TAutils.registerTargetingFacility(self:GetArmy())
	end
	end,

	OnIntelEnabled = function(self)
		TAStructure.OnIntelEnabled()
			if EntityCategoryContains(categories.TARGETING, self) and (self:IsIntelEnabled('Radar') or self:IsIntelEnabled('Sonar')) then
			TAutils.registerTargetingFacility(self:GetArmy())
			end
	end,

	OnIntelDisabled = function(self)
	TAStructure.OnIntelDisabled()
			if EntityCategoryContains(categories.TARGETING, self) and (not self:IsIntelEnabled('Radar') or not self:IsIntelEnabled('Sonar')) then
			TAutils.unregisterTargetingFacility(self:GetArmy())
		end
	end,

	IdleClosedState = State {
		Main = function(self)
			if self.closeDueToDamage then 
				while self.DamageSeconds > 0 do
					WaitSeconds(1)
					self.DamageSeconds = self.DamageSeconds - 1
				end

				self.closeDueToDamage = nil

				if self.intelIsActive then 
					ChangeState(self, self.OpeningState)
				end
			end
		end,

		OnDamage = function(self, instigator, amount, vector, damageType)
			TAStructure.OnDamage(self, instigator, amount, vector, damageType) 

			self.DamageSeconds = 8
			ChangeState(self, self.ClosingState)
		end,

	},

	IdleOpenState = State {
		Main = function(self)
		end,

		OnDamage = function(self, instigator, amount, vector, damageType)
			TAStructure.OnDamage(self, instigator, amount, vector, damageType)
			self.DamageSeconds = 8
			self.closeDueToDamage = true
			ChangeState(self, self.ClosingState)
		end,

	},

	OnScriptBitSet = function(self, bit)
		if bit == 3 then
			self.intelIsActive = nil
			ChangeState(self, self.ClosingState)
		end
		TAStructure.OnScriptBitSet(self, bit)
	end,


	OnScriptBitClear = function(self, bit)
		if bit == 3 then
			self.intelIsActive = true
			ChangeState(self, self.OpeningState)
		end
		TAStructure.OnScriptBitClear(self, bit)
	end,
}	
	
TACKFusion = Class(TAStructure) {
	OnStopBeingBuilt = function(self,builder,layer)
		TAStructure.OnStopBeingBuilt(self,builder,layer)
		self:SetScriptBit('RULEUTC_CloakToggle', false)
		self:RequestRefreshUI()
	end,

	
}

TAMine = Class(TACKFusion) {

	OnKilled = function(self, instigator, type, overkillRatio)
		if self.unit.attacked then
			instigator = self
		end
		TACKFusion.OnKilled(self, instigator, type, overkillRatio)
		
	end,	

}
