TABrainConditionsMonitor = BrainConditionsMonitor

BrainConditionsMonitor = Class (TABrainConditionsMonitor) {
    GetConditionKey = function(self, cFilename, cFunctionName, cData)
        if not self.Brain.SCTAAI then
            return TABrainConditionsMonitor.GetConditionKey(self, cFilename, cFunctionName, cData)
        end
        if not cFunctionName then
            error('*BUILD CONDITION MONITOR: Invalid BuilderCondition - Missing function name')
        elseif not cData or type(cData) != 'table' then
            error('*BUILD CONDITION MONITOR: Invalid BuilderCondition - Missing data table')
        end

        -- Key the TableConditions by filename
        if not self.ConditionData.TableConditions[cFilename] then
            self.ConditionData.TableConditions[cFilename] = {}
        end

        -- Key the filenames by function name
        if not self.ConditionData.TableConditions[cFilename][cFunctionName] then
            self.ConditionData.TableConditions[cFilename][cFunctionName] = {}
        end

        -- Check if the cData matches up
        for num,data in self.ConditionData.TableConditions[cFilename][cFunctionName] do
            -- Check if the data is the same length
            if table.getn(data.ConditionParameters) == table.getn(cData) then
                local match = true
                -- Check each piece of data to make sure it matches
                for k,v in data.ConditionParameters do
                    if v != cData[k] then
                        match = false
                        break
                    end
                end
                -- Match found, return the key
                if match then
                    return data.Key
                end
            end
        end

        -- No match found, so add the data to the table and return the key (same number as num items)
        local newCondition
        if cFilename == '/lua/editor/InstantBuildConditions.lua'
        or cFilename == '/lua/editor/UnitCountBuildConditions.lua'
        or cFilename == '/lua/editor/EconomyBuildConditions.lua'
        or cFilename == '/lua/editor/SorianInstantBuildConditions.lua'
        or cFilename == '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
        then
            newCondition = InstantImportCondition()
        else
            newCondition = ImportCondition()
        end
        newCondition:Create(self.Brain, table.getn(self.ResultTable) + 1, cFilename, cFunctionName, cData)
        table.insert(self.ResultTable, newCondition)

        -- Add in a hashed table for quicker key lookup, may not be necessary
        local newTable = {
            ConditionParameters = cData,
            Key = newCondition:GetKey(),
        }
        table.insert(self.ConditionData.TableConditions[cFilename][cFunctionName], newTable)
        return newTable.Key
    end,
}

