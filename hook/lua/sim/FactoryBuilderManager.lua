SCTAFactoryBuilderManager = FactoryBuilderManager
local CreateFactoryBuilder = import('/lua/sim/Builder.lua').CreateFactoryBuilder

FactoryBuilderManager = Class(SCTAFactoryBuilderManager, BuilderManager) {
    Create = function(self, brain, lType, location, radius, useCenterPoint)
        if not brain.SCTAAI then
            return SCTAFactoryBuilderManager.Create(self, brain, lType, location, radius, useCenterPoint)
        end
		BuilderManager.Create(self, brain)
        if not lType or not location or not radius then
            error('*FACTORY BUILDER MANAGER ERROR: Invalid parameters; requires locationType, location, and radius')
            return false
        end
        LOG('IEXISTFACT')
        local builderTypes = { 'Land', 'Air', 'KBot', 'Vehicle', 'Hover', 'Sea', 'Gate', }
        for _,v in builderTypes do
			self:AddBuilderType(v)
		end
        self.Location = location
        self.Radius = radius
        self.LocationType = lType
        self.RallyPoint = false

        self.FactoryList = {}

        self.LocationActive = false

        self.RandomSamePriority = true
        self.PlatoonListEmpty = true
	end,

    GetFactoryFaction = function(self, factory)
            if not self.Brain.SCTAAI then
                return SCTAFactoryBuilderManager.GetFactoryFaction(self, factory)
            end
            if EntityCategoryContains(categories.ARM, factory) then
                return 'Arm'
            elseif EntityCategoryContains(categories.CORE, factory) then
                return 'Core'
            end
            return false
        end,

        AddFactory = function(self,unit)
            if not self.Brain.SCTAAI then
                return SCTAFactoryBuilderManager.AddFactory(self, unit)
            end
            if not self:FactoryAlreadyExists(unit) then
                table.insert(self.FactoryList, unit)
                unit.DesiresAssist = true
                if EntityCategoryContains(categories.BOT, unit) then
                    self:SetupNewFactory(unit, 'KBot')
                elseif EntityCategoryContains(categories.TANK, unit) then
                    self:SetupNewFactory(unit, 'Vehicle')
                elseif EntityCategoryContains(categories.HOVER, unit) then
                    self:SetupNewFactory(unit, 'Hover')
                elseif EntityCategoryContains(categories.LAND, unit) then
                    self:SetupNewFactory(unit, 'Land')
                elseif EntityCategoryContains(categories.AIR, unit) then
                    self:SetupNewFactory(unit, 'Air')
                elseif EntityCategoryContains(categories.NAVAL, unit) then
                    self:SetupNewFactory(unit, 'Sea')
                else
                    self:SetupNewFactory(unit, 'Gate')
                end
                self.LocationActive = true
            end
        end,
----InitialVersion Below From LOUD
        SetRallyPoint = function(self, factory)
            if not self.Brain.SCTAAI then
                return SCTAFactoryBuilderManager.SetRallyPoint(self, factory)
            end
            WaitTicks(20)	  
            if not factory.Dead then
                local position = factory:GetPosition()     
                local rally = false           
                local rallyType = 'Rally Point'            
                if EntityCategoryContains(categories.NAVAL, factory) then
                    rallyType = 'Naval Rally Point'
                end
                rally = AIUtils.AIGetClosestMarkerLocation(self, rallyType, position[1], position[3])   
                if not rally or VDist3( rally, position ) > 100 then
                    position = import('/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua').TARandomLocation(position[1],position[3])
                    rally = position
                end           
                --IssueClearFactoryCommands( {factory} )
                IssueFactoryRallyPoint({factory}, rally)         
                factory:ForkThread(self.TrafficControlThread, position, rally)
            end
        end,
    
        -- thread runs as long as the factory is alive and monitors the units at that
        -- factory rally point - ordering them into formation if they are not in a platoon
        -- this helps alleviate traffic issues and 'stuck' unit problems
        TrafficControlThread = function(factory, factoryposition, rally)      
            WaitTicks(30)   
            local GetOwnUnitsAroundPoint = import('/lua/ai/aiutilities.lua').GetOwnUnitsAroundPoint     
            local category = categories.MOBILE - categories.EXPERIMENTAL - categories.AIR - categories.ENGINEER
            local rallypoint = { rally[1],rally[2],rally[3] }
            local factorypoint = { factoryposition[1], factoryposition[2], factoryposition[3] }       
            local Direction = import('/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua').GetDirectionInDegrees( rallypoint, factorypoint )
            if Direction < 45 then 
                Direction = 0		-- South        
            elseif Direction < 135 then   
                Direction = 90		-- East     
            elseif Direction < 225 then
                Direction = 180		-- North  
            else
                Direction = 270		-- West
            end
            local aiBrain = factory:GetAIBrain()            
            while true do         
                local unitlist = nil
                local units = nil           
                WaitTicks(900)
                units = GetOwnUnitsAroundPoint( aiBrain, category, rallypoint, 16)                
                if table.getn(units) > 10 then             
                    local unitlist = {}
                    for _,unit in units do            
                        if (unit.PlatoonHandle == aiBrain.ArmyPool) and unit:IsIdleState() then
                            table.insert( unitlist, unit )
                        end
                    end   
                    if table.getn(unitlist) > 10 then  
                        --LOG("*AI DEBUG "..aiBrain.Nickname.." TraffMgt of "..table.getn(unitlist).." at "..repr(rallypoint))
                        IssueClearCommands( unitlist )
                        IssueFormMove( unitlist, rallypoint, 'BlockFormation', Direction )
                    end
                end
            end
        end,

    }


--[[local position = factory:GetPosition()
local rally = false

if self.RallyPoint then
    IssueFactoryRallyPoint({factory}, self.RallyPoint)
    return true
end

local rallyType = 'Mass'
if EntityCategoryContains(categories.NAVAL, factory) then
    rallyType = 'Naval Area'
end

    -- use BuilderManager location
    rally = AIUtils.AIGetClosestMarkerLocation(self, rallyType, position[1], position[3])
    local expPoint = AIUtils.AIGetClosestMarkerLocation(self, 'Starting Location', position[1], position[3])

    if expPoint and rally then
        local rallyPointDistance = VDist2(position[1], position[3], rally[1], rally[3])
        local expansionDistance = VDist2(position[1], position[3], expPoint[1], expPoint[3])

        if expansionDistance < rallyPointDistance then
            rally = expPoint
        end
    end
end

-- Use factory location if no other rally or if rally point is far away
if not rally or VDist2(rally[1], rally[3], position[1], position[3]) > 75 then
    -- DUNCAN - added to try and vary the rally points.
    position = AIUtils.RandomLocation(position[1],position[3])
    rally = position
end
-- Use factory location if no other rally or if rally point is far away
IssueFactoryRallyPoint({factory}, rally)
self.RallyPoint = rally
return true
end,]]