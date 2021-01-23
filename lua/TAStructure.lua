#Generic TA unit
local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local scenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local Game = import('/lua/game.lua')
local util = import('/lua/utilities.lua')

TAStructure = Class(TAunit) 
{
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

    OnStopBeingBuilt = function(self,builder,layer)
        TAStructure.OnStopBeingBuilt(self,builder,layer)
        self:SetMaintenanceConsumptionActive()
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
	
TAnoassistbuild = Class(TAStructure) {
	OnCreate = function(self)
		TAStructure.OnCreate(self)
	end,
}

TAMine = Class(TAStructure) {

	OnKilled = function(self, instigator, type, overkillRatio)
		if self.unit.attacked then
			instigator = self
		end
		TAStructure.OnKilled(self, instigator, type, overkillRatio)
		
	end,
	OnStopBeingBuilt = function(self,builder,layer)
		TAStructure.OnStopBeingBuilt(self,builder,layer)
		self:SetMaintenanceConsumptionActive()
		self:SetScriptBit('RULEUTC_CloakToggle', false)
		self:RequestRefreshUI()
	end,


	HideFlares = function(self, bp)
	end,
}
