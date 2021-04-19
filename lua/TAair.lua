#Generic TA Air unit
local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit

TAair = Class(TAunit) 
{

	OnCreate = function(self)
        TAunit.OnCreate(self)
        self.HasFuel = true
	end,

	OnStartRefueling = function(self)
    end,
	
    OnMotionVertEventChange = function(self, new, old)
        TAunit.OnMotionVertEventChange(self, new, old)
		if (new == 'Down' or new == 'Bottom') then
			self:CloseWings()
			self:PlayUnitSound('Landing')
			local vis = self:GetBlueprint().Intel.VisionRadius / 2
            self:SetIntelRadius('Vision', vis)
        elseif (new == 'Up' or new == 'Top') then
			self:OpenWings()
			self:PlayUnitSound('TakeOff')
			local bpVision = self:GetBlueprint().Intel.VisionRadius
            if bpVision then
                self:SetIntelRadius('Vision', bpVision)
            else
                self:SetIntelRadius('Vision', 0)
            end
        end
	end,
	
	
	OnStopBeingBuilt = function(self,builder,layer)
		TAunit.OnStopBeingBuilt(self,builder,layer)
		self:OpenWings(self)
		self:PlayUnitSound('TakeOff')   
	end,

	OpenWings = function(self)
	end,

	CloseWings = function(self)
	end,

	OnRunOutOfFuel = function(self)
		self.HasFuel = false
        # penalize movement for running out of fuel
        self:SetSpeedMult(0.25)     # change the speed of the unit by this mult
        self:SetAccMult(0.25)       # change the acceleration of the unit by this mult
        self:SetTurnMult(0.25)      # change the turn ability of the unit by this mult
    end,

	OnGotFuel = function(self)
		self.HasFuel = true
        # revert these values to the blueprint values
        self:SetSpeedMult(1)
        self:SetAccMult(1)
        self:SetTurnMult(1)
	end,

    --- Called when the unit is killed, but before it falls out of the sky and blows up.
    OnKilled = function(self, instigator, type, overkillRatio)
		CreateAttachedEmitter(self, 0, -1, '/mods/SCTA-master/effects/emitters/debrisfire_smoke_emit.bp' )
		TAunit.OnKilled(self, instigator, type, overkillRatio)
    end,

}
TASeaair = Class(TAair) 
{
	OnStopBeingBuilt = function(self)
		TAair.OnStopBeingBuilt(self)
		self:DisableIntel('RadarStealth')
    end,

	OnMotionVertEventChange = function(self, new, old )
		---TAair.OnMotionVertEventChange(self, new, old)
			if (new == 'Down' or new == 'Bottom') then
						self:PlayUnitSound('Landing')
				self:CloseWings(self)
				ForkThread(self.OnLayerChange, self, new, old)
			elseif (new == 'Up' or new == 'Top') then
						self:PlayUnitSound('TakeOff')
				self:OpenWings(self)
			end
		end,

	OnLayerChange = function(self, new, old)
		--TAair.OnLayerChange(self, new, old)
		if( old != 'None' ) then
            if( self.AT1 ) then
                self.AT1:Destroy()
                self.AT1 = nil
			end
            local myBlueprint = self:GetBlueprint()
			if( new == 'Water' ) then
				self:EnableIntel('Vision')
                self:EnableIntel('WaterVision')
				self:EnableIntel('RadarStealth')
				self.Sliders.chassis:SetSpeed(12)
				self.Sliders.chassis:SetGoal(0,-12,0)
			elseif( new == 'Air' ) then
				self:EnableIntel('Vision')
                self:DisableIntel('WaterVision')
				self.Sliders.chassis:SetSpeed(12)
				self.Sliders.chassis:SetGoal(0,0,0)
				self:DisableIntel('RadarStealth')
				--ForkThread(self.OnMotionVertEventChange, self, new, old)
			end
		end
    end,

}

TAIntelAir = Class(TAair) {

	OnStopBeingBuilt = function(self,builder,layer)
		TAair.OnStopBeingBuilt(self,builder,layer)
		self:SetMaintenanceConsumptionActive()
		---if bp.Intel.RadarStealth or bp.Intel.RadarRadius then
		self:SetScriptBit('RULEUTC_StealthToggle', false)
		if self:GetBlueprint().Intel.TAIntel then
			self:SetScriptBit('RULEUTC_JammingToggle', true)
			self.MainCost = self:GetBlueprint().Economy.MaintenanceConsumptionPerSecondEnergy
			self.SpecIntel = true
			TAair.OnIntelEnabled(self)
		end
		self:RequestRefreshUI()
	end,
}