local WeaponFile = import('/lua/sim/DefaultWeapons.lua')
local DefaultWeapon = WeaponFile.DefaultProjectileWeapon
local KamikazeWeapon = WeaponFile.KamikazeWeapon
local BareBonesWeapon = WeaponFile.BareBonesWeapon
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')

TAweapon = Class(DefaultWeapon) {
    StartEconomyDrain = function(self)
        DefaultWeapon.StartEconomyDrain(self)
    end,
    
    OnGotTargetCheck = function(self)
        local army = self.unit:GetArmy()
        local canSee = true
        local target = self:GetCurrentTarget()
        local aiBrain = self.unit:GetAIBrain()
        if aiBrain.SCTAAI then
            return true
        else
        if (target) then
            if (IsUnit(target)) then
                canSee = target:GetBlip(army):IsSeenNow(army)
            end
            if (IsBlip(target)) then
                target = target:GetSource()
            end
        end

        local currentTarget = self.unit:GetTargetEntity()
        if (currentTarget and IsBlip(currentTarget)) then
            currentTarget = currentTarget:GetSource()
        end

        if (canSee == true or 
        currentTarget == target or
        (target and IsProp(target))) then
             return true
        else
            self:ResetTarget()
            return false
        end
    end
    end,

    IdleState = State(DefaultWeapon.IdleState) {
        OnGotTarget = function(self) 
            local army = self.unit:GetArmy()
            ---LOG('Resulting Table'..repr(TAutils.targetingFacilityData))
            if (TAutils.ArmyHasTargetingFacility(army) or 
            self:OnGotTargetCheck() == true) then
                DefaultWeapon.IdleState.OnGotTarget(self)
            end
        end,
    },

    WeaponUnpackingState = State(DefaultWeapon.WeaponUnpackingState) {
        Main = function(self)          
            local army = self.unit:GetArmy()
            ---LOG('Resulting Table'..repr(TAutils.targetingFacilityData))
            if (TAutils.ArmyHasTargetingFacility(army) or 
            self:OnGotTargetCheck() == true) then
                DefaultWeapon.WeaponUnpackingState.Main(self)
            else
                ChangeState(self, self.WeaponPackingState)
            end
        end,

        OnGotTarget = function(self)         
            local army = self.unit:GetArmy()
            ---LOG('Resulting Table'..repr(TAutils.targetingFacilityData))
            if (TAutils.ArmyHasTargetingFacility(army) or 
            self:OnGotTargetCheck() == true)  then
                DefaultWeapon.WeaponUnpackingState.OnGotTarget(self)
            end
        end,
    },

    RackSalvoFireReadyState = State(DefaultWeapon.RackSalvoFireReadyState) {
        WeaponWantEnabled = true,
        WeaponAimWantEnabled = true,

        Main = function(self)
            local bp = self:GetBlueprint()
            if (bp.CountedProjectile == true and bp.WeaponUnpacks == true) then
                self.unit:SetBusy(true)
            else
                self.unit:SetBusy(false)
            end
            self.WeaponCanFire = true
            if bp.EnergyRequired and bp.EnergyRequired > 0 then
                self.WeaponCanFire = false
                local aiBrain = self.unit:GetAIBrain()
                while aiBrain:GetEconomyStored('ENERGY') < bp.EnergyRequired do
                        WaitSeconds(1)
                end
                aiBrain:TakeResource('Energy', bp.EnergyRequired)
                self.WeaponCanFire = true
            end
            if bp.MassRequired and bp.MassRequired > 0 then
                self.WeaponCanFire = false
                local aiBrain = self.unit:GetAIBrain()
                while aiBrain:GetEconomyStored('MASS') < bp.MassRequired do
                        WaitSeconds(1)
                end
                aiBrain:TakeResource('Mass', bp.MassRequired)
                self.WeaponCanFire = true
            end
            if bp.CountedProjectile == true then
                ChangeState(self, self.RackSalvoFiringState)
            end

        end,

        OnGotTarget = function(self)      
            local army = self.unit:GetArmy()
            ---LOG('Resulting Table'..repr(TAutils.targetingFacilityData))
            if (TAutils.ArmyHasTargetingFacility(army) or 
            self:OnGotTargetCheck() == true) then
                DefaultWeapon.RackSalvoFireReadyState.OnGotTarget(self)
            end
        end,

        OnFire = function(self)
            if self.WeaponCanFire == true then
                ChangeState(self, self.RackSalvoFiringState)
            end
        end,

        OnLostTarget = function(self)
            DefaultWeapon.RackSalvoFireReadyState.OnLostTarget(self)
            local bp = self:GetBlueprint()
            if bp.WeaponUnpacks == true then
                ChangeState(self, self.WeaponPackingState)
            end
        end,

    },

    WeaponPackingState = State(DefaultWeapon.WeaponPackingState) {
        OnGotTarget = function(self)
            local army = self.unit:GetArmy()
            ---LOG('Resulting Table'..repr(TAutils.targetingFacilityData))
            if (TAutils.ArmyHasTargetingFacility(army) or 
            self:OnGotTargetCheck() == true)  then
                DefaultWeapon.WeaponPackingState.OnGotTarget(self)
            end
        end,
    },
}

TAHide = Class(TAweapon) {

    PlayFxWeaponUnpackSequence = function(self)
        self.unit.Pack = 1
        self.unit:DisableUnitIntel('RadarStealth')
        TAweapon.PlayFxWeaponUnpackSequence(self)
    end,

    PlayFxWeaponPackSequence = function(self)
        self.unit.Pack = 0.28
        self.unit:EnableUnitIntel('RadarStealth')
        TAweapon.PlayFxWeaponPackSequence(self)
    end,
}

TAPopLaser = Class(TAweapon) {

    PlayFxWeaponUnpackSequence = function(self)
        self.unit.Pack = 1
        TAweapon.PlayFxWeaponUnpackSequence(self)
    end,

    PlayFxWeaponPackSequence = function(self)
        self.unit.Pack = 0.5
        TAweapon.PlayFxWeaponPackSequence(self)
    end,
}

TARocket = Class(TAweapon) {
 -- Called when the weapon is created, almost always when the owning unit is created
 OnCreate = function(self)
    local bp = self:GetBlueprint()
    self.MassRequired = bp.MassRequired
    self.MassDrainPerSecond = bp.MassDrainPerSecond
    if bp.MassChargeForFirstShot == false then
        self.FirstShot = true
    end
    TAweapon.OnCreate(self)
end,


StartEconomyDrain = function(self)
    TAweapon.StartEconomyDrain(self)
    if self.FirstShot then return end
    local bp = self:GetBlueprint()
    if not self.MassDrain and bp.MassRequired and bp.MassDrainPerSecond then
        local MsReq = self:GetWeaponMassRequired()
        local MsDrain = self:GetWeaponMassDrain()
        if MsReq > 0 and MsDrain > 0 then
            local time = MsReq / MsDrain
            if time < 0.1 then
                time = 0.1
            end
            self.MassDrain = CreateEconomyEvent(self.unit, 0, MsReq, time)
            self.FirstShot = true
            self.unit:ForkThread(function()
                WaitFor(self.MassDrain)
                RemoveEconomyEvent(self.unit, self.MassDrain)
                self.MassDrain = nil
            end)
        end
    end
end,

GetWeaponMassRequired = function(self)
    local bp = self:GetBlueprint()
    local weapMass = (bp.MassRequired or 0)
    if weapMass < 0 then
        weapMass = 0
    end
    return weapMass
end,

GetWeaponMassDrain = function(self)
    local bp = self:GetBlueprint()
    local weapMass = (bp.MassDrainPerSecond or 0)
    return weapMass
end,
}

TAKami = Class(KamikazeWeapon){
    FxDeath = {
        '/mods/SCTA-master/effects/emitters/napalm_fire_emit.bp',
    },


    OnFire = function(self)
        local army = self.unit:GetArmy()
        for k, v in self.FxDeath do
            CreateEmitterAtBone(self.unit,-2,army,v):ScaleEmitter(3)
        end 
		local myBlueprint = self:GetBlueprint()
		KamikazeWeapon.OnFire(self)
    end,
}

TABomb = Class(BareBonesWeapon) {
    FxDeath = {
        '/mods/SCTA-master/effects/emitters/napalm_fire_emit.bp',
    },


    OnCreate = function(self)
        BareBonesWeapon.OnCreate(self)
        self:SetWeaponEnabled(false)   
    end,
    

    OnFire = function(self)
    end,
    
    Fire = function(self)
		local army = self.unit:GetArmy()
        for k, v in self.FxDeath do
            CreateEmitterAtBone(self.unit,-2,army,v):ScaleEmitter(3)
        end 
		local myBlueprint = self:GetBlueprint()
        DamageArea(self.unit, self.unit:GetPosition(), myBlueprint.DamageRadius, myBlueprint.Damage, myBlueprint.DamageType or 'Normal', myBlueprint.DamageFriendly or false)
    end,    

}


TACommanderDeathWeapon = Class(BareBonesWeapon) {
    OnCreate = function(self)
        BareBonesWeapon.OnCreate(self)
    end,
}

TADGun = Class(DefaultWeapon) {
    EnergyRequired = nil,

    HasEnergy = function(self)
        return self.unit:GetAIBrain():GetEconomyStored('ENERGY') >= self.EnergyRequired
    end,

    -- Can we use the OC weapon?
    CanOvercharge = function(self)
        return not self.unit:IsOverchargePaused() and self:HasEnergy() and not
            self:UnitOccupied() 
    end,

    UnitOccupied = function(self)
        return self.unit:IsUnitState('Building') or
            self.unit:IsUnitState('Repairing') or
            self.unit:IsUnitState('Reclaiming')
    end,

    PauseOvercharge = function(self)
        if not self.unit:IsOverchargePaused() then
            self.unit:SetOverchargePaused(true)
            WaitSeconds(1 / self:GetBlueprint().RateOfFire)
            self.unit:SetOverchargePaused(false)
        end
        if self.AutoMode then
            self.AutoThread = self:ForkThread(self.AutoEnable)
        end
    end,

    StartEconomyDrain = function(self) -- OverchargeWeapon drains energy on impact
    end,

        AutoEnable = function(self)
            while not self:CanOvercharge() do
                WaitSeconds(1)
            end
            if self.AutoMode then
                self.unit:SetWeaponEnabledByLabel('AutoDGun', true)
            end
        end,
    
        
    SetAutoOvercharge = function(self, auto)
            self.AutoMode = auto
    
            if self.AutoMode then
                self.AutoThread = self:ForkThread(self.AutoEnable)
            else
                if self.AutoThread then
                    KillThread(self.AutoThread)
                    self.AutoThread = nil
                end
            end
        end,

        OnCreate = function(self)
            DefaultWeapon.OnCreate(self)
            self.EnergyRequired = self:GetBlueprint().EnergyRequired
            self.unit:SetWeaponEnabledByLabel('DGun', true)
            self.unit:SetWeaponEnabledByLabel('AutoDGun', false)
            self.unit:SetOverchargePaused(false)
        end,

        OnWeaponFired = function(self)
            DefaultWeapon.StartEconomyDrain(self)
            self:ForkThread(self.PauseOvercharge)
        end,

        WaitDGUN = function(self)
            WaitSeconds(1 / self:GetBlueprint().RateOfFire)
        end,

        IdleState = State(DefaultWeapon.IdleState) {
            OnGotTarget = function(self)
                if self:CanOvercharge() then
                    DefaultWeapon.IdleState.OnGotTarget(self)
                else
                    self:ForkThread(function()
                        while not self:CanOvercharge() do
                            WaitSeconds(0.1)
                        end
                            self:OnGotTarget()
                    end)
                end
            end,
    
            OnFire = function(self)
                if self:CanOvercharge() then
                    ChangeState(self, self.RackSalvoFiringState)
                else
                    self:ForkThread(self.WaitDGUN)
                end
            end,
        },
    
        RackSalvoFireReadyState = State(DefaultWeapon.RackSalvoFireReadyState) {
            OnFire = function(self)
                if self:CanOvercharge() then
                    DefaultWeapon.RackSalvoFireReadyState.OnFire(self)
                else
                    self:ForkThread(self.WaitDGUN)
                end
            end,
        }    
}
