
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