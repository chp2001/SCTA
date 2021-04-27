--****************************************************************************
--**
--**  File     : /lua/wreckage.lua
--**
--**  Summary  : Class for wreckage so it can get pushed around
--**
--**  Copyright 2006 Gas Powered Games, Inc.  All rights reserved.
--****************************************************************************
local TADeath = import('/mods/SCTA-master/lua/TADeath.lua')

TAWreckage = Class(Prop) {
    
----this is for heaps the code itself is semi working just working on create heap function
    OnCreate = function(self)
        Prop.OnCreate(self)
        self.IsWreckage = true
        self.OrientationCache = self:GetOrientation()
    end,

    OnDamage = function(self, instigator, amount, vector, damageType)
        if not self.CanTakeDamage then end
        self:DoTakeDamage(instigator, amount, vector, damageType)
    end,

    OnDestroy = function(self)
        Prop.OnDestroy(self)
        TADeath.CreateHeapProp(self, 0)
    end,

    DoTakeDamage = function(self, instigator, amount, vector, damageType)
        self:AdjustHealth(instigator, -amount)
        local health = self:GetHealth()

        if health <= 0 then
            self:DoPropCallbacks('OnKilled')
            self:Destroy()
        else
            self:UpdateReclaimLeft()
        end
    end,

    OnCollisionCheck = function(self, other)
        if IsUnit(other) then
            return false
        else
            return true
        end
    end,

    --- Create and return an identical wreckage prop. Useful for replacing this one when something
    -- (a stupid engine bug) deleted it when we don't want it to.
    -- This function has the handle the case when *this* unit has already been destroyed. Notably,
    -- this means we have to calculate the health from the reclaim values, instead of going the
    -- other way.
    Clone = function(self)
        local clone = CreateWreckage(__blueprints[self.AssociatedBP], self.CachePosition, self.OrientationCache, self.MaxMassReclaim, self.MaxEnergyReclaim, self.TimeReclaim, self:GetCollisionExtents())

        -- Figure out the health this wreck had before it was deleted. We can't use any native
        -- functions like GetHealth(), so we use the latest known value

        clone:SetHealth(nil, clone:GetMaxHealth() * (self.ReclaimLeft or 1))
        clone:UpdateReclaimLeft()

        return clone
    end,
}