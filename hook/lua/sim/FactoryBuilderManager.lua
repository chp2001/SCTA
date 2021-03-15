taFactoryBuilderManager = FactoryBuilderManager
      
    FactoryBuilderManager = Class(taFactoryBuilderManager) {
        GetFactoryFaction = function(self, factory)
            if not self.Brain.SCTAAI then
                return taFactoryBuilderManager.GetFactoryFaction(self, factory)
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
                return taFactoryBuilderManager.RallyPointMonitor(self)
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

    }