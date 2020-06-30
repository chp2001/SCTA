    local OldCreateResources = CreateResources
    
    function CreateInitialArmyGroup(strArmy, createCommander)
        local tblGroup = CreateArmyGroup(strArmy, 'INITIAL')
        local cdrUnit = false
    
        if createCommander and (tblGroup == nil or 0 == table.getn(tblGroup) ) then
            local factionIndex = GetArmyBrain(strArmy):GetFactionIndex()
            local initialUnitName = import('mods/SCTA/hook/lua/factions.lua').Factions[factionIndex].InitialUnit
            cdrUnit = CreateInitialArmyUnit(strArmy, initialUnitName)
            if EntityCategoryContains(categories.COMMAND, cdrUnit) then
                if ScenarioInfo.Options['PrebuiltUnits'] == 'Off' then
                    #cdrUnit:HideBone(0, true)
                    ForkThread(CommanderWarpDelay, cdrUnit, 3)
                end
            end
        end
    



end