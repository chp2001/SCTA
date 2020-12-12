local TAair = import('/mods/SCTA-master/lua/TAair.lua').TAair
local Unit = import('/lua/sim/Unit.lua').Unit
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

TAAirConstructor = Class(TAair) {
    OnCreate = function(self)
        TAair.OnCreate(self) 
    
        self.EffectsBag = {}
        if self:GetBlueprint().General.BuildBones then
            self:SetupBuildBones()
        end

        if self:GetBlueprint().Display.AnimationBuild then
            self.BuildingOpenAnim = self:GetBlueprint().Display.AnimationBuild
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
    end,

    OnPaused = function(self)
        self:StopUnitAmbientSound( 'ConstructLoop' )
        TAair.OnPaused(self)
        if self.BuildingUnit then
            TAair.StopBuildingEffects(self, self:GetUnitBeingBuilt())
        end    
    end,
    
    OnUnpaused = function(self)
        if self.BuildingUnit then
            self:PlayUnitAmbientSound( 'ConstructLoop' )
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
        if unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo and order == 'Upgrade' then
            self.Upgrading = true
            self.BuildingUnit = false
        end
    end,

    OnStopBuild = function(self, unitBeingBuilt)
        TAair.OnStopBuild(self,unitBeingBuilt)
        if self.Upgrading then
            NotifyUpgrade(self,unitBeingBuilt)
            self:Destroy()
        end
        self.UnitBeingBuilt = nil
        self.UnitBuildOrder = nil

        if self.BuildingOpenAnimManip and self.BuildArmManipulator then
            self.StoppedBuilding = true
        elseif self.BuildingOpenAnimManip then
            self.BuildingOpenAnimManip:SetRate(-1)
        end
        self.BuildingUnit = false
    end,

    WaitForBuildAnimation = function(self, enable)
        if self.BuildArmManipulator then
            WaitFor(self.BuildingOpenAnimManip)
            if (enable) then
                self.BuildArmManipulator:Enable()
            end
        end
    end,

    OnPrepareArmToBuild = function(self)
        TAair.OnPrepareArmToBuild(self)

        #LOG( 'OnPrepareArmToBuild' )
        if self.BuildingOpenAnimManip then
            self.BuildingOpenAnimManip:SetRate(self:GetBlueprint().Display.AnimationBuildRate or 1)
            if self.BuildArmManipulator then
                self.StoppedBuilding = false
                ForkThread( self.WaitForBuildAnimation, self, true )
            end
        end
    end,

    OnStopBuilderTracking = function(self)
        TAair.OnStopBuilderTracking(self)

        if self.StoppedBuilding then
            self.StoppedBuilding = false
            self.BuildArmManipulator:Disable()
            self.BuildingOpenAnimManip:SetRate(-(self:GetBlueprint().Display.AnimationBuildRate or 1))
        end
    end,
    

    CheckBuildRestriction = function(self, target_bp)
        if self:CanBuild(target_bp.BlueprintId) then
            return true
        else
            return false
        end
    end,

	CreateBuildEffects = function(self, unitBeingBuilt, order)
        TAutils.CreateTABuildingEffects( self, unitBeingBuilt, self.BuildEffectBones, self.BuildEffectsBag )
    end,
}