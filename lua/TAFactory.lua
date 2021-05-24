local FactoryUnit = import('/lua/defaultunits.lua').FactoryUnit
local AircraftCarrier = import('/lua/defaultunits.lua').AircraftCarrier
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

TAFactory = Class(FactoryUnit) {
    OnCreate = function(self)
    FactoryUnit.OnCreate(self)
    self.AnimManip = CreateAnimator(self)
    self.Trash:Add(self.AnimManip)
    if __blueprints['armgant'] and not EntityCategoryContains(categories.TECH3 + categories.GATE, self) then
        TAutils.updateBuildRestrictions(self)
    end
    end,

    OnStopBeingBuilt = function(self, builder, layer)
        FactoryUnit.OnStopBeingBuilt(self, builder, layer)
        if __blueprints['armgant'] then
            local aiBrain = GetArmyBrain(self.Army)
            local buildRestrictionVictims = aiBrain:GetListOfUnits(categories.FACTORY + categories.ENGINEER, false)
            for id, unit in buildRestrictionVictims do    
            TAutils.TABuildRestrictions(unit)
            end
        end
    end,

        OnStartBuild = function(self, unitBeingBuilt, order )
            self:Open()
            ForkThread(self.FactoryStartBuild, self, unitBeingBuilt, order )
		end,

        FactoryStartBuild = function(self, unitBeingBuilt, order )
            WaitFor(self.AnimManip)
            if not self.Dead and not IsDestroyed(unitBeingBuilt) then
            self.TABuildingUnit = true      
            FactoryUnit.OnStartBuild(self, unitBeingBuilt, order )
            end
        end,

		Open = function(self)
            self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
            self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
        end,


        OnStopBuild = function(self, unitBuilding)
            self.TABuildingUnit = nil
            FactoryUnit.OnStopBuild(self, unitBuilding)
            self:Close()
		end,
        

		Close = function(self)
            self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
            self.AnimManip:SetRate(-0.1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
        end,

		CreateBuildEffects = function(self, unitBeingBuilt, order)
			TAutils.CreateTAFactBuildingEffects( self, unitBeingBuilt, self.BuildEffectBones, self.BuildEffectsBag )
        end,
    }
    
    TASeaFactory = Class(TAFactory) {
    CreateBuildEffects = function(self, unitBeingBuilt, order)
        TAutils.CreateTASeaFactBuildingEffects( self, unitBeingBuilt, self.BuildEffectBones, self.BuildEffectsBag )
    end,
    }
    
    TASeaPlat = Class(TAFactory) {
    OnStopBeingBuilt = function(self,builder,layer)
        self.Sliders = {
			chassis = CreateSlider(self, 0),
		}
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
        TAFactory.OnStopBeingBuilt(self,builder,layer)
        self:DisableIntel('RadarStealth')
        if layer == 'Water' then
            self.bp = self:GetBlueprint()
            self.scale = 0.5
            self.Water = true
            self:WaterFall()
        end
    end,   

    Close = function(self)
		TAFactory.Close(self)
		self:WaterFall()
	end,
    }

    TAGantry = Class(TAFactory) {

            CreateBuildEffects = function(self, unitBeingBuilt, order)
                TAutils.CreateTAGantBuildingEffects( self, unitBeingBuilt, self.BuildEffectBones, self.BuildEffectsBag )
            end,

            OnStartBuild = function(self, unitBeingBuilt, order )
                unitBeingBuilt:HideBone(0, true)
                TAFactory.OnStartBuild(self, unitBeingBuilt, order )
            end,
    
            FactoryStartBuild = function(self, unitBeingBuilt, order )
                TAFactory.FactoryStartBuild(self, unitBeingBuilt, order )
                unitBeingBuilt:ShowBone(0, true)
            end,
            
            Close = function(self)
                self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationPack)
                self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationPackRate or 0.2))
            end,
    
        }

TACarrier = Class(AircraftCarrier) {

    CreateBuildEffects = function(self, unitBeingBuilt, order)
        TAutils.CreateTAFactBuildingEffects( self, unitBeingBuilt, self.BuildEffectBones, self.BuildEffectsBag )
    end,
	
    OnFailedToBuild = function(self)
        AircraftCarrier.OnFailedToBuild(self)
        ChangeState(self, self.IdleState)
    end,

    IdleState = State {
        Main = function(self)
            self:DetachAll(self.BuildAttachBone)
            self:SetBusy(false)
        end,

		OnStartBuild = function(self, unitBuilding, order )
			self:Open()
			self.unitBeingBuilt = unitBuilding
			ForkThread(self.FactoryStartBuild, self, unitBuilding, order )
		end,

		FactoryStartBuild = function(self, unitBuilding, order )
			WaitFor(self.AnimManip)
            AircraftCarrier.OnStartBuild(self, unitBuilding, order)
            ChangeState(self, self.BuildingState)
		end,
		
		Open = function(self)
			self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationBuild)
			self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationBuildRate or 0.2))
            self.TABuildingUnit = true
        end,
	
    },

    BuildingState = State {
        Main = function(self)
            local unitBuilding = self.unitBeingBuilt
            self:SetBusy(true)
            local bone = self.BuildAttachBone
            self:DetachAll(bone)
            unitBuilding:HideBone(0, true)
            self.UnitDoneBeingBuilt = false
        end,

        OnStopBuild = function(self, unitBeingBuilt)
            AircraftCarrier.OnStopBuild(self, unitBeingBuilt)
            self:Close()
            ChangeState(self, self.FinishedBuildingState)
        end,
		
		Close = function(self)
			self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationBuild)
			self.AnimManip:SetRate(-1 * (self:GetBlueprint().Display.AnimationBuildRate or 0.2))
			self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationPower)
			self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationPowerRate or 0.2))
            self.TABuildingUnit = nil
        end,
    },

    FinishedBuildingState = State {
        Main = function(self)
            self:SetBusy(true)
            local unitBuilding = self.unitBeingBuilt
            unitBuilding:DetachFrom(true)
            self:DetachAll(self.BuildAttachBone)
            if self:TransportHasAvailableStorage() then
                self:AddUnitToStorage(unitBuilding)
            else
                local worldPos = self:CalculateWorldPositionFromRelative({0, 0, -20})
                IssueMoveOffFactory({unitBuilding}, worldPos)
                unitBuilding:ShowBone(0,true)
            end
            self:SetBusy(false)
			self:RequestRefreshUI()
			ChangeState(self, self.IdleState)
        end,
	},
}