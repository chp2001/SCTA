SCTAFactoryBuilderManager = FactoryBuilderManager

FactoryBuilderManager = Class(SCTAFactoryBuilderManager, BuilderManager) {
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
----InitialVersion Below From LOUD
        SetRallyPoint = function(self, factory)
            if not self.Brain.SCTAAI then
                return SCTAFactoryBuilderManager.SetRallyPoint(self, factory)
            end
            WaitTicks(20)
            if not EntityCategoryContains(categories.NAVAL, factory) and not factory.Dead then
                local position = factory:GetPosition()     
                local rally = false           
                local rallyType = 'Rally Point'            
                rally = AIUtils.AIGetClosestMarkerLocation(self, rallyType, position[1], position[3])   
                if not rally or VDist3( rally, position ) > 100 then
                    position = import('/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua').TARandomLocation(position[1],position[3])
                    rally = position
                end           
                --IssueClearFactoryCommands( {factory} )
                IssueFactoryRallyPoint({factory}, rally)         
                factory:ForkThread(self.TrafficControlThread, position, rally)
            end
        else
                rallytype = 'Naval Rally Point'
                    -- Find closest marker to averaged location
                    rally = AIUtils.AIGetClosestMarkerLocation(self, rallyType, position[1], position[3])
        
                -- Use factory location if no other rally or if rally point is far away
                if not rally or VDist2(rally[1], rally[3], position[1], position[3]) > 75 then
                    -- DUNCAN - added to try and vary the rally points.
                    position = AIUtils.RandomLocation(position[1],position[3])
                    rally = position
                end
                IssueFactoryRallyPoint({factory}, rally)
                self.RallyPoint = rally
                return true
        end,
    
        RallyPointMonitor = function(self)
            if not self.Brain.SCTAAI then
                return SCTAFactoryBuilderManager.RallyPointMonitor(self)
            end
            while true do
                if self.LocationActive and self.RallyPoint then
                    -- LOG('*AI DEBUG: Checking Active Rally Point')
                    local newRally = false
                    local bestDist = 99999
                    local rallyheight = GetTerrainHeight(self.RallyPoint[1], self.RallyPoint[3])
                    if self.Brain:GetNumUnitsAroundPoint(categories.STRUCTURE, self.RallyPoint, 15, 'Ally') > 0 then
                        -- LOG('*AI DEBUG: Searching for a new Rally Point Location')
                        for x = -30, 30, 5 do
                            for z = -30, 30, 5 do
                                local height = GetTerrainHeight(self.RallyPoint[1] + x, self.RallyPoint[3] + z)
                                if GetSurfaceHeight(self.RallyPoint[1] + x, self.RallyPoint[3] + z) > height or rallyheight > height + 10 or rallyheight < height - 10 then
                                    continue
                                end
                                local tempPos = { self.RallyPoint[1] + x, height, self.RallyPoint[3] + z }
                                if self.Brain:GetNumUnitsAroundPoint(categories.STRUCTURE, tempPos, 15, 'Ally') > 0 then
                                    continue
                                end
                                if not newRally or VDist2(tempPos[1], tempPos[3], self.RallyPoint[1], self.RallyPoint[3]) < bestDist then
                                    newRally = tempPos
                                    bestDist = VDist2(tempPos[1], tempPos[3], self.RallyPoint[1], self.RallyPoint[3])
                                end
                            end
                        end
                        if newRally then
                            self.RallyPoint = newRally
                            -- LOG('*AI DEBUG: Setting a new Rally Point Location')
                            for k,v in self.FactoryList do
                                IssueFactoryRallyPoint({v}, self.RallyPoint)
                            end
                        end
                    end
                end
                WaitSeconds(300)
            end
        end,

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