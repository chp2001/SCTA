#Generic TA Air unit
local AirTransport = import('/lua/defaultunits.lua').AirTransport
local FireSelfdestructWeapons = import('/lua/selfdestruct.lua').FireSelfdestructWeapons


TATransportAir = Class(AirTransport)
{
	OnCreate = function(self)
        AirTransport.OnCreate(self)
        self.HasFuel = true
        self.FxMovement = TrashBag()
	end,
	

    OnMotionVertEventChange = function(self, new, old)
        AirTransport.OnMotionVertEventChange(self, new, old)
        self.CreateMovementEffects(self)
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
		AirTransport.OnStopBeingBuilt(self,builder,layer)
		self:OpenWings(self)
		self:PlayUnitSound('TakeOff')
		self.KillingInProgress = nil
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
	
    Kill = function(self)
        if self.Dead or self.KillingInProgress then
            return
        end
        self.KillingInProgress = true
        --LOG('AirTransport.Kill ' .. self:GetBlueprint().General.UnitName)

        -- allow cargo to fire self destruct weapons (SelfDestructed flag is set in selfdestruct.lua)
        if self.SelfDestructed then
            --LOG('  yes self destruct:' .. self:GetBlueprint().General.UnitName)
            local cargo = self:GetCargo()
            --pcall(function() cargo = self:GetCargo() end)
            for _,unit in cargo or { } do
                --LOG('  firing cargo self-d weapons:' .. unit:GetBlueprint().General.UnitName)
                FireSelfdestructWeapons(unit)
            end
        end

        AirTransport.Kill(self)

    end,

    CreateMovementEffects = function(self, EffectsBag, TypeSuffix)
		if not IsDestroyed(self) then
		AirTransport.CreateMovementEffects(self, EffectsBag, TypeSuffix)
		local bp = self:GetBlueprint()
		if self:IsUnitState('Moving') and bp.Display.MovementEffects.TAMovement then
			for k, v in bp.Display.MovementEffects.TAMovement.Bones do
				self.FxMovement:Add(CreateAttachedEmitter(self, v, self:GetArmy(), bp.Display.MovementEffects.TAMovement.Emitter ):ScaleEmitter(bp.Display.MovementEffects.TAMovement.Scale))
			end
			elseif not self:IsUnitState('Moving') then
			for k,v in self.FxMovement do
				v:Destroy()
			end
		end
		end
	end,

}