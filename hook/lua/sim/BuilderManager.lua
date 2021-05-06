
-- Hook for debugging
SCTABuilderManager = BuilderManager
BuilderManager = Class(SCTABuilderManager) {
    -- Hook for not deleting priority 0 platoon
    -- Hook for Uveso AI debug
    GetHighestBuilder = function(self,bType,params)
        ----This Is needed Because Uveso 
        if not self.Brain.SCTAAI then
            return SCTABuilderManager.GetHighestBuilder(self,bType,params)
        end
        if not self.BuilderData[bType] then
            error('*BUILDERMANAGER ERROR: Invalid builder type - ' .. bType)
        end
        if not self.Brain.BuilderManagers[self.LocationType] then
            return false
        end
        self.NumGet = self.NumGet + 1
        local found = false
        local possibleBuilders = {}
        for k,v in self.BuilderData[bType].Builders do
            if v.Priority >= 1 and self:BuilderParamCheck(v,params) and (not found or v.Priority == found) and v:GetBuilderStatus() then
                if not self:IsPlattonBuildDelayed(v.DelayEqualBuildPlattons) then
                    found = v.Priority
                    table.insert(possibleBuilders, k)
                end
            elseif found and v.Priority < found then
                break
            end
        end
        if found and found > 0 then
            local whichBuilder = Random(1,table.getn(possibleBuilders))
            return self.BuilderData[bType].Builders[ possibleBuilders[whichBuilder] ]
        end
        return false
    end,

}

---Talk to Uveso about this
--[[SortBuilderList = function(self, bType)
    -- Only use this with AI-Uveso
     if not self.Brain.SCTAAI then
         return TheOldBuilderManager.SortBuilderList(self, bType)
     end
     -- Make sure there is a type
     if not self.BuilderData[bType] then
         error('*BUILDMANAGER ERROR: Trying to sort platoons of invalid builder type - ' .. bType)
         return false
     end
     -- bubblesort self.BuilderData[bType].Builders
     local count=table.getn(self.BuilderData[bType].Builders)
     local Sorting
     repeat
         Sorting = false
         count = count - 1
         for i = 1, count do
             if self.BuilderData[bType].Builders[i].Priority < self.BuilderData[bType].Builders[i + 1].Priority then
                 self.BuilderData[bType].Builders[i], self.BuilderData[bType].Builders[i + 1] = self.BuilderData[bType].Builders[i + 1], self.BuilderData[bType].Builders[i]
                 Sorting = true
             end
         end
     until Sorting == false
     -- mark the table as sorted
     self.BuilderData[bType].NeedSort = false
 end,]]