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
        
        if bp.Display.AnimationBuild then
            self.BuildingOpenAnim = bp.Display.AnimationBuild
        end

        if self.BuildingOpenAnim then
            self.BuildingOpenAnimManip = CreateAnimator(self)
            self.BuildingOpenAnimManip:SetPrecedence(1)
            self.BuildingOpenAnimManip:PlayAnim(self.BuildingOpenAnim, false):SetRate(0)
            if self.BuildArmManipulator then
                self.BuildArmManipulator:Disable()
            end
        end
        self.BuildingUnit = false
        if __blueprints['armmass'] then
            TAutils.updateBuildRestrictions(self)
        end
    end,

    OnFailedToBuild = function(self)
        TAair.OnFailedToBuild(self)
        self:SetImmobile(false)
    end,

    OnPaused = function(self)
        self:StopUnitAmbientSound('Construct')
        TAair.OnPaused(self)
        if self.BuildingUnit then
            TAair.StopBuildingEffects(self, self.UnitBeingBuilt)
        end
    end,

    OnUnpaused = function(self)
        if self.BuildingUnit then
            self:PlayUnitAmbientSound('Construct')
            TAair.StartBuildingEffects(self, self.UnitBeingBuilt, self.UnitBuildOrder)
        end
        TAair.OnUnpaused(self)
    end,
    
    OnStartBuild = function(self, unitBeingBuilt, order )
        TAair.OnStartBuild(self,unitBeingBuilt, order)
        self.UnitBeingBuilt = unitBeingBuilt
        self.UnitBuildOrder = order
        self.BuildingUnit = true
    end,


    OnStopBuild = function(self, unitBeingBuilt)
        TAair.OnStopBuild(self,unitBeingBuilt)
        self.UnitBeingBuilt = nil
        self.UnitBuildOrder = nil

        if self.BuildingOpenAnimManip and self.BuildArmManipulator then
            self.StoppedBuilding = true
        elseif self.BuildingOpenAnimManip then
            self.BuildingOpenAnimManip:SetRate(-1)
        end
        self.BuildingUnit = false
        self:SetImmobile(false)
        if __blueprints['armmass'] then
            TAutils.updateBuildRestrictions(self)
        end
    end,

    WaitForBuildAnimation = function(self, enable)
        if self.BuildArmManipulator then
            WaitFor(self.BuildingOpenAnimManip)
            if enable then
                self.BuildArmManipulator:Enable()
            end
        end
    end,
    
    OnStopBuilderTracking = function(self)
        TAair.OnStopBuilderTracking(self)
        if self.StoppedBuilding then
            self.StoppedBuilding = false
            self.BuildArmManipulator:Disable()
            self.BuildingOpenAnimManip:SetRate(-(self:GetBlueprint().Display.AnimationBuildRate or 1))
            self:SetImmobile(false)
        end
    end,

    OnPrepareArmToBuild = function(self)
        TAair.OnPrepareArmToBuild(self)  
        if self.BuildingOpenAnimManip then
            self.BuildingOpenAnimManip:SetRate(self:GetBlueprint().Display.AnimationBuildRate or 1)
            if self.BuildArmManipulator then
                self.StoppedBuilding = false
                self:ForkThread(self.WaitForBuildAnimation, true)
            end
        end
        if self:IsMoving() then
            self:SetImmobile(true)
            self:ForkThread(function() WaitTicks(1) if not self:BeenDestroyed() then self:SetImmobile(false) end end)
        end
    end,

    OnStopReclaim = function(self, target)
        TAair.OnStopReclaim(self, target)
        if self.BuildingOpenAnimManip then
            self.BuildingOpenAnimManip:SetRate(-1)
        end
    end,

    CreateBuildEffects = function( self, unitBeingBuilt, order )
        self.BuildEffectsBag:Add( TAutils.CreateTAAirBuildingEffects( self, unitBeingBuilt, self.BuildEffectBones, self.BuildEffectsBag ))
    end,

    CreateReclaimEffects = function( self, target )
        self.ReclaimEffectsBag:Add(TAutils.TAAirReclaimEffects(self, target, self.BuildEffectBones or {0, }, self.ReclaimEffectsBag))
    end,
     
}