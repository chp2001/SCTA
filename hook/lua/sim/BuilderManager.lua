
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

