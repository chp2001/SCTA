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
        TAutils.ArmyHasTargetingFacility(army) == true or
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
            if (self:OnGotTargetCheck() == true) then
                DefaultWeapon.IdleState.OnGotTarget(self)
            end
        end,
    },

    WeaponUnpackingState = State(DefaultWeapon.WeaponUnpackingState) {
        Main = function(self)
            if (self:OnGotTargetCheck() == true) then
                DefaultWeapon.WeaponUnpackingState.Main(self)
            else
                ChangeState(self, self.WeaponPackingState)
            end
        end,

        OnGotTarget = function(self)
            if (self:OnGotTargetCheck() == true) then
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
            if bp.CountedProjectile == true then
                ChangeState(self, self.RackSalvoFiringState)
            end

        end,

        OnGotTarget = function(self)
            if (self:OnGotTargetCheck() == true) then
                DefaultWeapon.RackSalvoFireReadyState.OnGotTarget(self)
            end
        end,

        OnFire = function(self)
            if self.WeaponCanFire then
                ChangeState(self, self.RackSalvoFiringState)
            end
        end,

        OnLostTarget = function(self)
            local bp = self:GetBlueprint()
            if bp.WeaponUnpacks == true then
                ChangeState(self, self.WeaponPackingState)
            end
        end,

    },

    WeaponPackingState = State(DefaultWeapon.WeaponPackingState) {
        OnGotTarget = function(self)
            if (self:OnGotTargetCheck() == true) then
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

TAKami = Class(KamikazeWeapon){
    FxMuzzleFlash = {
        '/effects/emitters/default_muzzle_flash_01_emit.bp',
        '/effects/emitters/default_muzzle_flash_02_emit.bp',
    },

    OnFire = function(self)
		local army = self.unit:GetArmy()
		KamikazeWeapon.OnFire(self)
    end,
}

TABomb = Class(BareBonesWeapon) {
    FxMuzzleFlash = {
        '/effects/emitters/default_muzzle_flash_01_emit.bp',
        '/effects/emitters/default_muzzle_flash_02_emit.bp',
    },

    OnCreate = function(self)
        BareBonesWeapon.OnCreate(self)
        self:SetWeaponEnabled(false)   
    end,
    

    OnFire = function(self)
    end,
    
    Fire = function(self)
		local army = self.unit:GetArmy()
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

    StartEconomyDrain = function(self) -- OverchargeWeapon drains energy on impact
    end,

    OnWeaponFired = function(self)
        self:ForkThread(self.PauseOvercharge)
    end,

    OnLostTarget = function(self)
        self.unit:SetWeaponEnabledByLabel('DGun', true)
        if self.AutoMode then
            self.AutoThread = self:ForkThread(self.AutoEnable)
        end
        TAweapon.OnLostTarget(self)
    end,


    PauseOvercharge = function(self)
        if not self.unit:IsOverchargePaused() then
            self.unit:SetOverchargePaused(true)
            WaitSeconds(1 / self:GetBlueprint().RateOfFire)
            self.unit:SetOverchargePaused(false)
        end
        self.unit:SetWeaponEnabledByLabel('DGun', true)
        if self.AutoMode then
            self.AutoThread = self:ForkThread(self.AutoEnable)
        end
    end,

        OnCreate = function(self)
            DefaultWeapon.OnCreate(self)
            self.EnergyRequired = self:GetBlueprint().EnergyRequired
            self.unit:SetWeaponEnabledByLabel('DGun', true)
            self.unit:SetWeaponEnabledByLabel('AutoDGun', false)
            self.unit:SetOverchargePaused(false)
        end,

        AutoEnable = function(self)
            while not self:CanOvercharge() do
                WaitSeconds(3)
            end
            if self.AutoMode then
                self.unit:SetWeaponEnabledByLabel('DGun', false)
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
                    self.unit:SetWeaponEnabledByLabel('AutoDGun', false)
                    self.unit:SetWeaponEnabledByLabel('DGun', true)
                    self.AutoThread = nil
                end
            end
        end,
    
}
