local TAair = import('/mods/SCTA-master/lua/TAair.lua').TAair
local Unit = import('/lua/sim/Unit.lua').Unit
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

TAAirConstructor = Class(TAair) {
    OnCreate = function(self)
        TAair.OnCreate(self) 
    
        local bp = self:GetBlueprint()

        -- Save build effect bones for faster access when creating build effects
        self.BuildEffectBones = bp.General.BuildBones.BuildEffectBones

        self.EffectsBag = {}
        if bp.General.BuildBones then
            self:SetupBuildBones()
        end
        self.BuildingUnit = false
    end,

    OnFailedToBuild = function(self)
        TAair.OnFailedToBuild(self)
        self:SetImmobile(false)
    end,

    OnPaused = function(self)
        TAair.OnPaused(self)
        if self.BuildingUnit then
            TAair.StopBuildingEffects(self, self:GetUnitBeingBuilt())
        end    
    end,
    
    OnUnpaused = function(self)
        if self.BuildingUnit then
            TAair.StartBuildingEffects(self, self:GetUnitBeingBuilt(), self.UnitBuildOrder)
        end
        TAair.OnUnpaused(self)
    end,
    
    OnStartBuild = function(self, unitBeingBuilt, order )
        TAair.OnStartBuild(self,unitBeingBuilt, order)
        #Fix up info on the unit id from the blueprint and see if it matches the 'UpgradeTo' field in the BP.
        self.UnitBeingBuilt = unitBeingBuilt
        self.UnitBuildOrder = order
        self.BuildingUnit = true
    end,

    OnStopBuild = function(self, unitBeingBuilt)
        TAair.OnStopBuild(self,unitBeingBuilt)
        self.UnitBeingBuilt = nil
        self.UnitBuildOrder = nil
        self.BuildingUnit = false
    end,

    OnStopBuilderTracking = function(self)
        TAair.OnStopBuilderTracking(self)
        if self.StoppedBuilding then
            self.StoppedBuilding = false
            self.BuildArmManipulator:Disable()
            self:SetImmobile(false)
        end
    end,

    OnPrepareArmToBuild = function(self)
        TAair.OnPrepareArmToBuild(self)  
         if self:IsMoving() then
            self:SetImmobile(true)
            self:ForkThread(function() WaitTicks(1) if not self:BeenDestroyed() then self:SetImmobile(false) end end)
        end
    end,

    OnStartReclaim = function(self, target)
        TAair.OnStartReclaim(self, target)
    end,
    
	CreateBuildEffects = function(self, unitBeingBuilt, order)
        TAutils.CreateTAAirBuildingEffects( self, unitBeingBuilt, self.BuildEffectBones, self.BuildEffectsBag )
    end,

    CreateReclaimEffects = function( self, target )
		TAutils.TAAirReclaimEffects( self, target, self:GetBlueprint().General.BuildBones.BuildEffectBones or {0,}, self.ReclaimEffectsBag )
    end,

    CreateReclaimEndEffects = function( self, target )
        EffectUtil.PlayReclaimEndEffects( self, target )
    end,         
}