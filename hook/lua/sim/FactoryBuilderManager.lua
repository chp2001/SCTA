WARN('['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] * SCTAAI: offset FactoryBuilderManager.lua' )

SCTAFactoryBuilderManager = FactoryBuilderManager
FactoryBuilderManager = Class(SCTAFactoryBuilderManager) {
    Create = function(self, brain, lType, location, radius, useCenterPoint)
        if not brain.SCTAAI then
            return SCTAFactoryBuilderManager.Create(self, brain, lType, location, radius, useCenterPoint)
        end
		BuilderManager.Create(self, brain)
        if not lType or not location or not radius then
            error('*FACTORY BUILDER MANAGER ERROR: Invalid parameters; requires locationType, location, and radius')
            return false
        end
        --LOG('IEXISTFACT')
        local builderTypes = {'Air', 'KBot', 'Vehicle', 'Hover', 'Sea', 'Seaplane', 'Gate', }
        for _,v in builderTypes do
			self:AddBuilderType(v)
		end
        self.Location = location
        --LOG('*Location', self.Location)
        self.Radius = radius
        self.LocationType = lType
        --LOG('*Location', self.LocationType)
        self.RallyPoint = false

        self.FactoryList = {}

        self.LocationActive = false

        self.RandomSamePriority = true
        self.PlatoonListEmpty = true
	end,

    AddBuilder = function(self, builderData, locationType)
        if not self.Brain.SCTAAI then
            return SCTAFactoryBuilderManager.AddBuilder(self, builderData, locationType)
        end
        local newBuilder = Builder.CreateFactoryBuilder(self.Brain, builderData, locationType)
        if newBuilder:GetBuilderType() == 'All' then
            for k,v in self.BuilderData do
                self:AddInstancedBuilder(newBuilder, k)
            end
        elseif newBuilder:GetBuilderType() == 'Land' then
            for __,v in self.BuilderData do
                self:AddInstancedBuilder(newBuilder, 'KBot')
                self:AddInstancedBuilder(newBuilder, 'Vehicle')
            end
        elseif newBuilder:GetBuilderType() == 'SpecHover' then
            for __,v in self.BuilderData do
                self:AddInstancedBuilder(newBuilder, 'KBot')
                self:AddInstancedBuilder(newBuilder, 'Vehicle')
                self:AddInstancedBuilder(newBuilder, 'Hover')
                self:AddInstancedBuilder(newBuilder, 'Sea')
            end
        elseif newBuilder:GetBuilderType() == 'SpecAir' then
            for __,v in self.BuilderData do
                self:AddInstancedBuilder(newBuilder, 'Air')
                self:AddInstancedBuilder(newBuilder, 'Seaplane')
            end
        elseif newBuilder:GetBuilderType() == 'Field' then
            for __,v in self.BuilderData do
                self:AddInstancedBuilder(newBuilder, 'KBot')
                self:AddInstancedBuilder(newBuilder, 'Vehicle')
                self:AddInstancedBuilder(newBuilder, 'Air')
            end
        else
            self:AddInstancedBuilder(newBuilder)
        end
        return newBuilder
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
              if not EntityCategoryContains(categories.TECH1, unit) then
                unit.DesiresAssist = true
                else
                unit.DesiresAssist = false
              end
                if EntityCategoryContains(categories.BOT, unit) then
                    self:SetupNewFactory(unit, 'KBot')
                elseif EntityCategoryContains(categories.TANK, unit) then
                    self:SetupNewFactory(unit, 'Vehicle')
                elseif EntityCategoryContains(categories.GATE, unit) then
                    self:SetupNewFactory(unit, 'Gate')
                elseif EntityCategoryContains(categories.SUBMERSIBLE, unit) then
                    self:SetupNewFactory(unit, 'Seaplane')
                elseif EntityCategoryContains(categories.AIR - categories.SUBMERSIBLE, unit) then
                    self:SetupNewFactory(unit, 'Air')
                elseif EntityCategoryContains(categories.NAVAL, unit) then
                    self:SetupNewFactory(unit, 'Sea')
                else
                    self:SetupNewFactory(unit, 'Hover')
                end
                self.LocationActive = true
            end
        end,

        GetFactoriesBuildingCategory = function(self, category, facCategory)
            if not self.Brain.SCTAAI then
                return SCTAFactoryBuilderManager.GetFactoriesBuildingCategory(self, category, facCategory)
            end
            local units = {}
            for k,v in EntityCategoryFilterDown(facCategory, self.FactoryList) do
                if v.Dead then
                    continue
                end
    
                if not v:IsUnitState('Building') then
                    continue
                end
    
                local beingBuiltUnit = v.UnitBeingBuilt
                if not beingBuiltUnit or beingBuiltUnit.Dead then
                    continue
                end
    
                if not EntityCategoryContains(category, beingBuiltUnit) then
                    continue
                end
    
                table.insert(units, v)
            end
            return units
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
            local Direction = import('/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua').TAGetDirectionInDegrees( rallypoint, factorypoint )
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

        DelayBuildOrder = function(self,factory,bType,time)
            if not self.Brain.SCTAAI then
                return SCTAFactoryBuilderManager.DelayBuildOrder(self,factory,bType,time)
            end
            local guards = factory:GetGuards()
            for k,v in guards do
                if not v.Dead and v.AssistPlatoon then
                    if self.Brain:PlatoonExists(v.AssistPlatoon) then
                        v.AssistPlatoon:ForkThread(v.AssistPlatoon.EconAssistBody)
                    else
                        v.AssistPlatoon = nil
                    end
                end
            end
            if factory.DelayThread then
                return
            end
            factory.DelayThread = true
            WaitSeconds(time)
            factory.DelayThread = false
            self:TAAssignBuildOrder(factory,bType)
        end,

        FactoryFinishBuilding = function(self,factory,finishedUnit)
            if not self.Brain.SCTAAI then
                return SCTAFactoryBuilderManager.FactoryFinishBuilding(self,factory,finishedUnit)
            end
            if EntityCategoryContains(categories.ENGINEER, finishedUnit) then
                self.Brain.BuilderManagers[self.LocationType].EngineerManager:AddUnit(finishedUnit)
            elseif EntityCategoryContains(categories.FACTORY, finishedUnit) then
                self:AddFactory(finishedUnit)
            end
            self:TAAssignBuildOrder(factory, factory.BuilderManagerData.BuilderType)
        end,

        TAAssignBuildOrder = function(self,factory,bType)
            --LOG('*TAIEXIST3', factory.TABuildingUnit)
            if factory.Dead then
                return
            end
            --LOG('*TAIEXIST2', factory.TABuildingUnit)
            local builder = self:GetHighestBuilder(bType,{factory})
            --LOG('*TAIEXIST2', factory)
            --LOG('*TAIEXIST', factory.TABuildingUnit)
                if builder and not factory.TABuildingUnit then
                ---LOG('*TAIEXIST3', factory)
                local template = self:GetFactoryTemplate(builder:GetPlatoonTemplate(), factory)
                LOG('*TAAI DEBUG: ARMY ', repr(self.Brain:GetArmyIndex()),': Factory Builder Manager Building - ',repr(builder.BuilderName))

                -- rename factory to actual build-platoon name
                if self.Brain[ScenarioInfo.Options.AIPLatoonNameDebug] or ScenarioInfo.Options.AIPLatoonNameDebug == 'all' then
                    factory:SetCustomName(builder.BuilderName)
                end

                --LOG('*Building', template)
                self.Brain:BuildPlatoon(template, {factory}, 1)
                --LOG('*TACanceling2', template)
                else
                    --LOG('*TAIEXIST4', factory.TABuildingUnit)
                -- rename factory
                if self.Brain[ScenarioInfo.Options.AIPLatoonNameDebug] or ScenarioInfo.Options.AIPLatoonNameDebug == 'all' then
                    if factory:IsUnitState('Upgrading') and factory.PlatoonHandle.BuilderName then
                        factory:SetCustomName(factory.PlatoonHandle.BuilderName)
                    elseif factory:IsIdleState() then
                        factory:SetCustomName('')
                    end
                end
                -- No builder found setup way to check again
                self:ForkThread(self.DelayBuildOrder, factory, bType, 2)
                --LOG('*TACanceling1', factory)
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