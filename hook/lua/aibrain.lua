WARN('['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] * SCTAAI: offset aibrain.lua' )

SCTAAIBrainClass = AIBrain
AIBrain = Class(SCTAAIBrainClass) {
        OnSpawnPreBuiltUnits = function(self)
            if not self.SCTAAI then
                return SCTAAIBrainClass.OnSpawnPreBuiltUnits(self)
            end
            local per = ScenarioInfo.ArmySetup[self.Name].AIPersonality
            local resourceStructures = nil
            local initialUnits = nil
            local posX, posY = self:GetArmyStartPos()
    
            if string.find(per, 'arm') then
                resourceStructures = {'armmex', 'armmex', 'armmex', 'armmex'}
                initialUnits = {'armlab', 'armsolar', 'armsolar', 'armsolar', 'armsolar'}
            else
                resourceStructures = {'cormex', 'cormex', 'cormex', 'cormex'}
                initialUnits = {'corvp', 'corsolar', 'corsolar', 'corsolar', 'corsolar'}
            end
    
            if resourceStructures then
                -- Place resource structures down
                for k, v in resourceStructures do
                    local unit = self:CreateResourceBuildingNearest(v, posX, posY)
                end
            end
    
            if initialUnits then
                -- Place initial units down
                for k, v in initialUnits do
                    local unit = self:CreateUnitNearSpot(v, posX, posY)
                end
            end
    
            self.PreBuilt = true
        end,
       

    AddBuilderManagers = function(self, position, radius, baseName, useCenter)
        -- Only use this with AI-Uveso
         if not self.SCTAAI then
             return SCTAAIBrainClass.AddBuilderManagers(self, position, radius, baseName, useCenter)
         end
         --LOG('*templateManager', self.SCTAAI)
         self.BuilderManagers[baseName] = {
             FactoryManager = FactoryManager.CreateFactoryBuilderManager(self, baseName, position, radius, useCenter),
             PlatoonFormManager = PlatoonFormManager.CreatePlatoonFormManager(self, baseName, position, radius, useCenter),
             EngineerManager = EngineerManager.CreateEngineerManager(self, baseName, position, radius),
             MassConsumption = {
                 Resources = {Units = {}, Drain = 0, },
                 Units = {Units = {}, Drain = 0, },
                 Defenses = {Units = {}, Drain = 0, },
                 Upgrades = {Units = {}, Drain = 0, },
                 Engineers = {Units = {}, Drain = 0, },
                 TotalDrain = 0,
             },
             BuilderHandles = {},
             Position = position,
             BaseType = Scenario.MasterChain._MASTERCHAIN_.Markers[baseName].type or 'MAIN',
         }
         self.NumBases = self.NumBases + 1
         --self:InitializePlatoonBuildManager()
     end,

    OnCreateAI = function(self, planName)
        SCTAAIBrainClass.OnCreateAI(self, planName)
        local per = ScenarioInfo.ArmySetup[self.Name].AIPersonality
        --LOG('Oncreate')
        if string.find(per, 'scta') then
            --LOG('* AI-SCTA: This is SCTA')
            self.SCTAAI = true
        end
    end,

    PBMBuildNumFactories = function (self, template, location, pType, factory)
        --LOG('*template2', self.SCTAAI)
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMBuildNumFactories(self, template, location, pType, factory)
        end
        local retTemplate = table.deepcopy(template)
        local assistFacs = factory[1]:GetGuards()
        table.insert(assistFacs, factory[1])
        local facs = {T1 = 0, T2 = 0, T3 = 0}
        for _, v in assistFacs do
        if EntityCategoryContains(categories.FACTORY * (categories.TECH3 + categories.GATE), v) then
                facs.T3 = facs.T3 + 1
            elseif EntityCategoryContains(categories.TECH2 * categories.FACTORY, v) then
                facs.T2 = facs.T2 + 1
            elseif EntityCategoryContains(categories.FACTORY, v) then
                facs.T1 = facs.T1 + 1
            end
        end

        -- Handle any squads with a specified build quantity
        local squad = 3
        while squad <= table.getn(retTemplate) do
            if retTemplate[squad][2] > 0 then
                local bp = self:GetUnitBlueprint(retTemplate[squad][1])
                local buildLevel = AIBuildUnits.SCTAUnitBuildCheck(bp)
                local remaining = retTemplate[squad][3]
                while buildLevel <= 3 do
                    if facs['T'..buildLevel] > 0 then
                        if facs['T'..buildLevel] < remaining then
                            remaining = remaining - facs['T'..buildLevel]
                            facs['T'..buildLevel] = 0
                            buildLevel = buildLevel + 1
                        else
                            facs['T'..buildLevel] = facs['T'..buildLevel] - remaining
                            buildLevel = 10
                        end
                    else
                        buildLevel = buildLevel + 1
                    end
                end
            end
            squad = squad + 1
        end

        -- Handle squads with programatic build quantity
        squad = 3
        local remainingIds = {T1 = {}, T2 = {}, T3 = {}}
        while squad <= table.getn(retTemplate) do
            if retTemplate[squad][2] < 0 then
                table.insert(remainingIds['T'..AIBuildUnits.SCTAUnitBuildCheck(self:GetUnitBlueprint(retTemplate[squad][1])) ], retTemplate[squad][1])
            end
            squad = squad + 1
        end
        local rTechLevel = 3
        while rTechLevel >= 1 do
            for num, unitId in remainingIds['T'..rTechLevel] do
                for tempRow = 3, table.getn(retTemplate) do
                    if retTemplate[tempRow][1] == unitId and retTemplate[tempRow][2] < 0 then
                        retTemplate[tempRow][3] = 0
                        for fTechLevel = rTechLevel, 3 do
                            retTemplate[tempRow][3] = retTemplate[tempRow][3] + (facs['T'..fTechLevel] * math.abs(retTemplate[tempRow][2]))
                            facs['T'..fTechLevel] = 0
                        end
                    end
                end
            end
            rTechLevel = rTechLevel - 1
        end

        -- Remove any IDs with 0 as a build quantity.
        for i = 1, table.getn(retTemplate) do
            if i >= 3 then
                if retTemplate[i][3] == 0 then
                    table.remove(retTemplate, i)
                end
            end
        end

        return retTemplate
    end,

    PBMAssistGivenFactory = function( self, factories, primary )
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMAssistGivenFactory( self, factories, primary )
        end
        for k,v in factories do
            if not v:IsDead() and not ( v:IsUnitState('Building')) then
                local guarded = v:GetGuardedUnit()
                if not guarded or guarded:GetEntityId() ~= primary:GetEntityId() then
                    IssueFactoryAssist( {v}, primary )
                end
            end
        end
    end,

    PBMSetRallyPoint = function(self, factories, location, rallyLoc, markerType)
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMSetRallyPoint(self, factories, location, rallyLoc, markerType)
        end
        if table.getn(factories) > 0 then
            local rally
            local position = factories[1]:GetPosition()
            for facNum, facData in factories do
                if facNum > 1 then
                    position[1] = position[1] + facData:GetPosition()[1]
                    position[3] = position[3] + facData:GetPosition()[3]
                end
            end
            position[1] = position[1] / table.getn(factories)
            position[3] = position[3] / table.getn(factories)
            if not rallyLoc and not location.UseCenterPoint then
                local pnt
                if not markerType then
                    pnt = AIUtils.AIGetClosestMarkerLocation( self, 'Rally Point', position[1], position[3] )
                else
                    pnt = AIUtils.AIGetClosestMarkerLocation( self, markerType, position[1], position[3] )
                end
                if(pnt and table.getn(pnt) == 3) then
                    rally = Vector(pnt[1], pnt[2], pnt[3])
                end
            elseif not rallyLoc and location.UseCenterPoint then
                rally = location.Location
            elseif rallyLoc then
                rally = rallyLoc
            else
                error('*ERROR: PBMSetRallyPoint - Missing Rally Location and Marker Type', 2)
                return false
            end
            if(rally) then
                for k,v in factories do
                    IssueFactoryRallyPoint({v}, rally)
                end
            end
        end
        return true
    end,

    ForceManagerSort = function(self)
        if not self.SCTAAI then
            return SCTAAIBrainClass.ForceManagerSort(self)
        end
        for _, v in self.BuilderManagers do
            ----TAEngineerType
            v.EngineerManager:SortBuilderList('LandTA')
            v.EngineerManager:SortBuilderList('AirTA')
            v.EngineerManager:SortBuilderList('SeaTA')
            v.EngineerManager:SortBuilderList('T3TA')
            v.EngineerManager:SortBuilderList('FieldTA')
            v.EngineerManager:SortBuilderList('Command')
            ---TAFactoryType
            v.FactoryManager:SortBuilderList('KBot')
            v.FactoryManager:SortBuilderList('Vehicle')
            v.FactoryManager:SortBuilderList('Hover')
            v.FactoryManager:SortBuilderList('Air')
            v.FactoryManager:SortBuilderList('Seaplane')
            v.FactoryManager:SortBuilderList('Sea')
            v.FactoryManager:SortBuilderList('Gate')
            ---TAPlatoonFormers
            v.PlatoonFormManager:SortBuilderList('LandForm')
            v.PlatoonFormManager:SortBuilderList('AirForm')
            v.PlatoonFormManager:SortBuilderList('SeaForm')
            v.PlatoonFormManager:SortBuilderList('Scout')
            v.PlatoonFormManager:SortBuilderList('EngineerForm')
            v.PlatoonFormManager:SortBuilderList('CommandTA')
            v.PlatoonFormManager:SortBuilderList('Other')
            v.PlatoonFormManager:SortBuilderList('StructureForm')
        end
    end,


    UnderEnergyThreshold = function(self)
        if not self.Brain.SCTAAI then
            return SCTAAIBrainClass.UnderEnergyThreshold(self)
        end
        LOG('IEXIST')
        self:SetupOverEnergyStatTrigger(0.175)
        for k, v in self.BuilderManagers do
           v.EngineerManager:LowEnergy()
        end
    end,

    OverEnergyThreshold = function(self)
        if not self.Brain.SCTAAI then
            return SCTAAIBrainClass.OverEnergyThreshold(self)
        end
        LOG('IEXIST2')
        self:SetupUnderEnergyStatTrigger(0.15)
        for k, v in self.BuilderManagers do
            v.EngineerManager:RestoreEnergy()
        end
    end,

    UnderMassThreshold = function(self)
        if not self.Brain.SCTAAI then
            return SCTAAIBrainClass.UnderMassThreshold(self)
        end
        LOG('IEXIST3')
        self:SetupOverMassStatTrigger(0.125)
        for k, v in self.BuilderManagers do
            v.EngineerManager:LowMass()
        end
    end,

    OverMassThreshold = function(self)
        if not self.Brain.SCTAAI then
            return SCTAAIBrainClass.OverMassThreshold(self)
        end
        LOG('IEXIST4')
        self:SetupUnderMassStatTrigger(0.1)
        for k, v in self.BuilderManagers do
            v.EngineerManager:RestoreMass()
        end
    end,

    InitializePlatoonBuildManager = function(self)
        if not self.SCTAAI then
            return SCTAAIBrainClass.InitializePlatoonBuildManager(self)
        end
        if not self.PBM then
            self.PBM = {
                Platoons = {
                    Air = {},
                    Seaplane = {},
                    KBot = {},
                    Vehicle = {},
                    Hover = {},
                    Sea = {},
                    Gate = {},
                },
                Locations = {
                    -- {
                    --  Location,
                    --  Radius,
                    --  LocType, ('MAIN', 'EXPANSION')
                    --  PrimaryFactories = {Air = X, Land = Y, Sea = Z}
                    --  UseCenterPoint, - Bool
                    --}
                },
                PlatoonTypes = {'Air', 'KBot', 'Vehicle', 'Hover', 'Sea', 'Seaplane', 'Gate', },
                NeedSort = {
                    ['Air'] = false,
                    ['KBot'] = false,
                    ['Sea'] = false,
                    ['Seaplane'] = false,
                    ['Hover'] = false,
                    ['Vehicle'] = false,
                    ['Gate'] = false,
                },
                RandomSamePriority = false,
                BuildConditionsTable = {},
            }
            -- Create basic starting area
            local strtX, strtZ = self:GetArmyStartPos()
            self:PBMAddBuildLocation({strtX, 20, strtZ}, 100, 'MAIN')

            -- TURNING OFF AI POOL PLATOON, I MAY JUST REMOVE THAT PLATOON FUNCTIONALITY LATER
            local poolPlatoon = self:GetPlatoonUniquelyNamed('ArmyPool')
            if poolPlatoon then
                poolPlatoon:TurnOffPoolAI()
            end
            --LOG('IEXIST')
            self.HasPlatoonList = false
            self:PBMSetEnabled(true)
        end
    end,

    -- Platoon Spec
    -- {
    --       PlatoonTemplate = platoon template,
    --       InstanceCount = number of duplicates to place in the platoon list
    --       Priority = integer,
    --       BuildConditions = list of functions that return true/false, list of args, {< function>, {<args>}}
    --       LocationType = string for type of location, setup via addnewlocation function,
    --       BuildTimeOut = how long it'll try to form this platoon after it's been told to build.,
    --       PlatoonType = 'Air'/'Land'/'Sea' basic type of unit, used for finding what type of factory to build from,
    --       RequiresConstruction = true/false do I need to build this from a factory or should I just try to form it?,
    --       PlatoonBuildCallbacks = {FunctionsToCallBack when the platoon starts to build}
    --       PlatoonAIFunction = if nil uses function in platoon.lua, function for the main AI thread
    --       PlatoonAddFunctions = {<other threads to be forked on this platoon>}
    --       PlatoonData = {
    --           Construction = {
    --               BaseTemplate = basetemplates, must contain templates for all 3 factions it will be viewed by faction index,
    --               BuildingTemplate = building templates, contain templates for all 3 factions it will be viewed by faction index,
    --               BuildClose = true/false do I follow the table order or do build the best spot near me?
    --               BuildRelative = true/false are the build coordinates relative to the starting location or absolute coords?,
    --               BuildStructures = {List of structure types and the order to build them.}
    --          }
    --      }
    --  },
    PBMAddPlatoon = function(self, pltnTable)
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMAddPlatoon(self, pltnTable)
        end
        if not pltnTable.PlatoonTemplate then
            local stng = '*AI ERROR: INVALID PLATOON LIST IN '.. self.CurrentPlan.. ' - MISSING TEMPLATE.  '
            error(stng, 1)
            return
        end

        if pltnTable.RequiresConstruction == nil then
            error('*AI ERROR: INVALID PLATOON LIST IN ' .. self.CurrentPlan .. ' - MISSING RequiresConstruction', 1)
            return
        end

        if not pltnTable.Priority then
            error('*AI ERROR: INVALID PLATOON LIST IN ' .. self.CurrentPlan .. ' - MISSING PRIORITY', 1)
            return
        end

        if not pltnTable.BuildConditions then
            pltnTable.BuildConditions = {}
        end

        if not pltnTable.BuildTimeOut or pltnTable.BuildTimeOut == 0 then
            pltnTable.GenerateTimeOut = true
        end

        local num = 1
        if pltnTable.InstanceCount and pltnTable.InstanceCount > 1 then
            num = pltnTable.InstanceCount
        end

        if not ScenarioInfo.BuilderTable[self.CurrentPlan] then
            ScenarioInfo.BuilderTable[self.CurrentPlan] = {Air = {}, Sea = {}, Kbot = {}, Vehicle = {}, Seaplane = {}, Hover = {}, Gate = {}}
        end

        if pltnTable.PlatoonType ~= 'Any' then
            if not ScenarioInfo.BuilderTable[self.CurrentPlan][pltnTable.PlatoonType][pltnTable.BuilderName] then
                ScenarioInfo.BuilderTable[self.CurrentPlan][pltnTable.PlatoonType][pltnTable.BuilderName] = pltnTable
            elseif not pltnTable.Inserted then
                error('AI DEBUG: BUILDER DUPLICATE NAME FOUND - ' .. pltnTable.BuilderName, 2)
            end
            local insertTable = {BuilderName = pltnTable.BuilderName, PlatoonHandles = {}, Priority = pltnTable.Priority, LocationType = pltnTable.LocationType, PlatoonTemplate = pltnTable.PlatoonTemplate}
            for i = 1, num do
                table.insert(insertTable.PlatoonHandles, false)
            end

            table.insert(self.PBM.Platoons[pltnTable.PlatoonType], insertTable)
            self.PBM.NeedSort[pltnTable.PlatoonType] = true
        else
            local insertTable = {BuilderName = pltnTable.BuilderName, PlatoonHandles = {}, Priority = pltnTable.Priority, LocationType = pltnTable.LocationType, PlatoonTemplate = pltnTable.PlatoonTemplate}
            for i = 1, num do
                table.insert(insertTable.PlatoonHandles, false)
            end
            local types = {'Air', 'KBot', 'Vehicle', 'Hover', 'Sea', 'Seaplane', 'Gate', }
            for num, pType in types do
                if not ScenarioInfo.BuilderTable[self.CurrentPlan][pType][pltnTable.BuilderName] then
                    ScenarioInfo.BuilderTable[self.CurrentPlan][pType][pltnTable.BuilderName] = pltnTable
                elseif not pltnTable.Inserted then
                    error('AI DEBUG: BUILDER DUPLICATE NAME FOUND - ' .. pltnTable.BuilderName, 2)
                end
                table.insert(self.PBM.Platoons[pType], insertTable)
                self.PBM.NeedSort[pType] = true
            end
        end

        self.HasPlatoonList = true
    end,


    -- Function to clear all the platoon lists so you can feed it a bunch more.
    -- formPlatoons - Gives you the option to form all the platoons in the list before its cleaned up so that
    -- you don't have units hanging around.
    PBMClearPlatoonList = function(self, formPlatoons)
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMClearPlatoonList(self, formPlatoons)
        end
        if formPlatoons then
            for _, v in self.PBM.PlatoonTypes do
                self:PBMFormPlatoons(false, v)
            end
        end
        self.PBM.NeedSort['Air'] = false
        self.PBM.NeedSort['KBot'] = false
        self.PBM.NeedSort['Seaplane'] = false
        self.PBM.NeedSort['Hover'] = false
        self.PBM.NeedSort['Vehicle'] = false
        self.PBM.NeedSort['Sea'] = false
        self.PBM.NeedSort['Gate'] = false
        self.HasPlatoonList = false
        self.PBM.Platoons = {
            Air = {},
            Seaplane = {},
            KBot = {},
            Vehicle = {},
            Hover = {},
            Sea = {},
            Gate = {},
        }
    end,

    PBMResetPrimaryFactories = function(self)
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMResetPrimaryFactories(self)
        end
        for _, v in self.PBM.Locations do
            v.PrimaryFactories.Air = nil
            v.PrimaryFactories.KBot = nil
            v.PrimaryFactories.Seaplane = nil
            v.PrimaryFactories.Hover = nil
            v.PrimaryFactories.Vehicle = nil
            v.PrimaryFactories.Sea = nil
            v.PrimaryFactories.Gate = nil
        end
    end,

    -- Goes through the location areas, finds the factories, sets a primary then tells all the others to guard.
    PBMSetPrimaryFactories = function(self)
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMSetPrimaryFactories(self)
        end
        for _, v in self.PBM.Locations do
            local factories = self:GetAvailableFactories(v.Location, v.Radius)
            local hoverFactories = {}
            local kbotFactories = {}
            local seaplaneFactories = {}
            local airFactories = {}
            local vehicleFactories = {}
            local seaFactories = {}
            local gates = {}
            for ek, ev in factories do
                if EntityCategoryContains(categories.FACTORY * categories.AIR - categories.SUBMERSIBLE, ev) and self:PBMFactoryLocationCheck(ev, v) then
                    table.insert(airFactories, ev)
                elseif EntityCategoryContains(categories.FACTORY * categories.TANK, ev) and self:PBMFactoryLocationCheck(ev, v) then
                    table.insert(vehicleFactories, ev)
                elseif EntityCategoryContains(categories.FACTORY * categories.BOT, ev) and self:PBMFactoryLocationCheck(ev, v) then
                    table.insert(kbotFactories, ev)
                elseif EntityCategoryContains(categories.FACTORY * categories.LAND * categories.TECH3, ev) and self:PBMFactoryLocationCheck(ev, v) then
                    table.insert(hoverFactories, ev)
                elseif EntityCategoryContains(categories.FACTORY * categories.AIR * categories.TECH3 - categories.MOBILE, ev) and self:PBMFactoryLocationCheck(ev, v) then
                    table.insert(seaplaneFactories, ev)
                elseif EntityCategoryContains(categories.FACTORY * categories.NAVAL * categories.STRUCTURE, ev) and self:PBMFactoryLocationCheck(ev, v) then
                    table.insert(seaFactories, ev)
                elseif EntityCategoryContains(categories.FACTORY * categories.GATE, ev) and self:PBMFactoryLocationCheck(ev, v) then
                    table.insert(gates, ev)
                end
            end

            local afac, kfac, sfac, vfac, hfac, pfac, gatefac
            if table.getn(airFactories) > 0 then
                if not v.PrimaryFactories.Air or v.PrimaryFactories.Air.Dead
                    or self:PBMCheckHighestTechFactory(airFactories, v.PrimaryFactories.Air) then
                        fac = self:PBMGetPrimaryFactory(airFactories)
                        v.PrimaryFactories.Air = afac
                end
                self:PBMAssistGivenFactory(airFactories, v.PrimaryFactories.Air)
            end

            if table.getn(kbotFactories) > 0 then
                if not v.PrimaryFactories.KBot or v.PrimaryFactories.KBot.Dead
                    or self:PBMCheckHighestTechFactory(kbotFactories, v.PrimaryFactories.KBot) then
                        lfac = self:PBMGetPrimaryFactory(kbotFactories)
                        v.PrimaryFactories.KBot = kfac
                end
                self:PBMAssistGivenFactory(kbotFactories, v.PrimaryFactories.KBot)
            end

            if table.getn(seaFactories) > 0 then
                if not v.PrimaryFactories.Sea or v.PrimaryFactories.Sea.Dead
                    or self:PBMCheckHighestTechFactory(seaFactories, v.PrimaryFactories.Sea) then
                        sfac = self:PBMGetPrimaryFactory(seaFactories)
                        v.PrimaryFactories.Sea = sfac
                end
                self:PBMAssistGivenFactory(seaFactories, v.PrimaryFactories.Sea)
            end
            if table.getn(hoverFactories) > 0 then
                if not v.PrimaryFactories.Hover or v.PrimaryFactories.Hover.Dead
                    or self:PBMCheckHighestTechFactory(hoverFactories, v.PrimaryFactories.Hover) then
                        fac = self:PBMGetPrimaryFactory(hoverFactories)
                        v.PrimaryFactories.Hover = hfac
                end
                self:PBMAssistGivenFactory(hoverFactories, v.PrimaryFactories.Hover)
            end

            if table.getn(vehicleFactories) > 0 then
                if not v.PrimaryFactories.Vehicle or v.PrimaryFactories.Vehicle.Dead
                    or self:PBMCheckHighestTechFactory(vehicleFactories, v.PrimaryFactories.Vehicle) then
                        lfac = self:PBMGetPrimaryFactory(vehicleFactories)
                        v.PrimaryFactories.Vehicle = vfac
                end
                self:PBMAssistGivenFactory(vehicleFactories, v.PrimaryFactories.Vehicle)
            end

            if table.getn(seaplaneFactories) > 0 then
                if not v.PrimaryFactories.Seaplane or v.PrimaryFactories.Seaplane.Dead
                    or self:PBMCheckHighestTechFactory(seaplaneFactories, v.PrimaryFactories.Seaplane) then
                        sfac = self:PBMGetPrimaryFactory(seaplaneFactories)
                        v.PrimaryFactories.Seaplane = pfac
                end
                self:PBMAssistGivenFactory(seaplanneFactories, v.PrimaryFactories.Seaplane)
            end

            if table.getn(gates) > 0 then
                if not v.PrimaryFactories.Gate or v.PrimaryFactories.Gate.Dead then
                    gatefac = self:PBMGetPrimaryFactory(gates)
                    v.PrimaryFactories.Gate = gatefac
                end
                self:PBMAssistGivenFactory(gates, v.PrimaryFactories.Gate)
            end

            if not v.RallyPoint or table.getn(v.RallyPoint) == 0 then
                self:PBMSetRallyPoint(airFactories, v, nil)
                self:PBMSetRallyPoint(kbotFactories, v, nil)
                self:PBMSetRallyPoint(seaplaneFactories, v, nil)
                self:PBMSetRallyPoint(hoverFactories, v, nil)
                self:PBMSetRallyPoint(vehicleFactories, v, nil)
                self:PBMSetRallyPoint(seaFactories, v, nil)
                self:PBMSetRallyPoint(gates, v, nil)
            end
        end
    end,

    PBMSetPriority = function(self, platoon, amount)
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMSetPriority(self, platoon, amount)
        end
        for typek, typev in self.PBM.PlatoonTypes do
            for k, v in self.PBM.Platoons[typev] do
                if not v.PlatoonHandles then
                    error('*AI DEBUG: No PlatoonHandles for builder - ' .. v.BuilderName)
                    return false
                end
                for num, plat in v.PlatoonHandles do
                    if plat == platoon then
                        if typev == 'Any' then
                            self.PBM.NeedSort['Air'] = true
                            self.PBM.NeedSort['KBot'] = true
                            self.PBM.NeedSort['Seaplane'] = true
                            self.PBM.NeedSort['Hover'] = true
                            self.PBM.NeedSort['Vehicle'] = true
                            self.PBM.NeedSort['Sea'] = true
                            self.PBM.NeedSort['Gate'] = true
                        else
                            self.PBM.NeedSort[typev] = true
                        end
                        v.Priority = amount
                    end
                end
            end
        end
    end,

    -- Adds a new build location
    PBMAddBuildLocation = function(self, loc, radius, locType, useCenterPoint)
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMAddBuildLocation(self, loc, radius, locType, useCenterPoint)
        end
        if not radius or not loc or not locType then
            error('*AI ERROR: INVALID BUILD LOCATION FOR PBM', 2)
            return false
        end
        if type(loc) == 'string' then
            loc = ScenarioUtils.MarkerToPosition(loc)
        end

        useCenterPoint = useCenterPoint or false
        local spec = {
            Location = loc,
            Radius = radius,
            LocationType = locType,
            PrimaryFactories = {Air = nil, Vehicle = nil, Sea = nil, Hover = nil, KBot = nil, Seaplane = nil, Gate = nil},
            UseCenterPoint = useCenterPoint,
        }

        local found = false
        for num, loc in self.PBM.Locations do
            if loc.LocationType == spec.LocationType then
                found = true
                break
            end
        end

        if not found then
            table.insert(self.PBM.Locations, spec)
        else
            error('*AI  ERROR: Attempting to add a build location with a duplicate name: '..spec.LocationType, 2)
            return
        end
    end,

    -- Removes a build location based on it area
    -- IF either is nil, then it will do the other.
    -- This way you can remove all of one type or all of one rectangle


    -- Sort platoon list
    -- PlatoonType = 'Air', 'Land' or 'Sea'
    PBMSortPlatoonsViaPriority = function(self, platoonType)
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMSortPlatoonsViaPriority(self, platoonType)
        end
        if platoonType ~= 'Air' and platoonType ~= 'Vehicle' and platoonType ~= 'Sea' and platoonType ~= 'Gate' and platoonType ~= 'Hover' and platoonType ~= 'KBot' and platoonType ~= 'Seaplane' then
            local strng = '*AI ERROR: TRYING TO SORT PLATOONS VIA PRIORITY BUT AN INVALID TYPE (', repr(platoonType), ') WAS PASSED IN.'
            error(strng, 2)
            return false
        end
        local sortedList = {}
        -- Simple selection sort, this can be made faster later if we decide we need it.
        for i = 1, table.getn(self.PBM.Platoons[platoonType]) do
            local highest = 0
            local key, value
            for k, v in self.PBM.Platoons[platoonType] do
                if v.Priority > highest then
                    highest = v.Priority
                    value = v
                    key = k
                end
            end
            sortedList[i] = value
            table.remove(self.PBM.Platoons[platoonType], key)
        end
        self.PBM.Platoons[platoonType] = sortedList
        self.PBM.NeedSort[platoonType] = false
    end,

    PBMAdjustPriority = function(self, platoon, amount)
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMAdjustPriority(self, platoon, amount)
        end
        for typek, typev in self.PBM.PlatoonTypes do
            for k, v in self.PBM.Platoons[typev] do
                if not v.PlatoonHandles then
                    error('*AI DEBUG: No PlatoonHandles for builder - ' .. v.BuilderName)
                    return false
                end
                for num, plat in v.PlatoonHandles do
                    if plat == platoon then
                        if typev == 'Any' then
                            self.PBM.NeedSort['Air'] = true
                            self.PBM.NeedSort['KBot'] = true
                            self.PBM.NeedSort['Seaplane'] = true
                            self.PBM.NeedSort['Hover'] = true
                            self.PBM.NeedSort['Vehicle'] = true
                            self.PBM.NeedSort['Sea'] = true
                            self.PBM.NeedSort['Gate'] = true
                        else
                            self.PBM.NeedSort[typev] = true
                        end
                        v.Priority = v.Priority + amount
                    end
                end
            end
        end
    end,

    PBMGetPrimaryFactory = function(self, factories)
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMGetPrimaryFactory(self, factories)
        end
        local categoryTable = {categories.GATE, categories.TECH3, categories.TECH2, categories.TECH1}
        for kc, vc in categoryTable do
            for k, v in factories do
                if EntityCategoryContains(vc, v) then
                    return v
                end
            end
        end
    end,

    PBMGetNumFactoriesAtLocation = function(self, location, pType)
        if not self.SCTAAI then
            return SCTAAIBrainClass.PBMGetNumFactoriesAtLocation(self, location, pType)
        end
        local hoverFactories = {}
        local kbotFactories = {}
        local seaplaneFactories = {}
        local airFactories = {}
        local vehicleFactories = {}
        local seaFactories = {}
        local gates = {}
        local factories = self:GetAvailableFactories(location.Location, location.Radius)
        local numFactories = 0
        for ek, ev in factories do
            if EntityCategoryContains(categories.FACTORY * categories.AIR - categories.SUBMERSIBLE, ev) then
                table.insert(airFactories, ev)
            elseif EntityCategoryContains(categories.FACTORY * categories.BOT, ev) then
                table.insert(kbotFactories, ev)
            elseif EntityCategoryContains(categories.FACTORY * categories.AIR * categories.TECH3 - categories.MOBILE, ev) then
                table.insert(seaplaneFactories, ev)
            elseif EntityCategoryContains(categories.FACTORY * categories.GATE, ev) then
                table.insert(gates, ev)
            elseif EntityCategoryContains(categories.FACTORY * categories.TANK, ev) then
                table.insert(vehicleFactories, ev)
            elseif EntityCategoryContains(categories.FACTORY * categories.NAVAL - categories.MOBILE, ev) then
                table.insert(seaFactories, ev)
            elseif EntityCategoryContains(categories.FACTORY * categories.LAND * categories.TECH3, ev) then
                table.insert(hoverFactories, ev)
            end
        end

        local retFacs = {}
        if pType == 'Air' then
            numFactories = table.getn(airFactories)
        elseif pType == 'Vehicle' then
            numFactories = table.getn(vehicleFactories)
        elseif pType == 'Sea' then
            numFactories = table.getn(seaFactories)
        elseif pType == 'Gate' then
            numFactories = table.getn(gates)
        elseif pType == 'KBot' then
            numFactories = table.getn(kbotFactories)
        elseif pType == 'Seaplane' then
            numFactories = table.getn(seaplaneFactories)
        elseif pType == 'Hover' then
            numFactories = table.getn(hoverFactories)
        end

        return numFactories
    end,
}