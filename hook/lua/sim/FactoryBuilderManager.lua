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

        SetRallyPoint = function(self, factory)
            if not self.Brain.SCTAAI then
                return SCTAFactoryBuilderManager.SetRallyPoint(self, factory)
            end
            local position = factory:GetPosition()
            local rally = false
    
            if self.RallyPoint then
                IssueFactoryRallyPoint({factory}, self.RallyPoint)
                return true
            end
    
            local rallyType = 'Rally Point'
            if EntityCategoryContains(categories.NAVAL, factory) then
                rallyType = 'Naval Rally Point'
            end
    
            if not self.UseCenterPoint then
                -- Find closest marker to averaged location
                rally = AIUtils.AIGetClosestMarkerLocation(self, rallyType, position[1], position[3])
            elseif self.UseCenterPoint then
                -- use BuilderManager location
                rally = AIUtils.AIGetClosestMarkerLocation(self, rallyType, position[1], position[3])
                local expPoint = AIUtils.AIGetClosestMarkerLocation(self, 'Expansion Area', position[1], position[3])
    
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
            IssueFactoryRallyPoint({factory}, rally)
            self.RallyPoint = rally
            return true
        end,

    }