function CreateInitialArmyGroup(strArmy, createCommander)
	local tblGroup, cdrUnit = doGateSpawn(strArmy, createCommander)
    return tblGroup, cdrUnit
end

function doGateSpawn(strArmy, createCommander)
            #--[Combat Drops/HotDrops by Senteth Loken.       ]--
            #--[I would like to add this and other options as a lobby option so it can be played on any map.     ]--

    local tblGroup = CreateArmyGroup(strArmy, 'INITIAL')
    local cdrUnit = false
    if createCommander and ( tblGroup == nil or 0 == table.getn(tblGroup) ) then
        local factionIndex = GetArmyBrain(strArmy):GetFactionIndex()
        local initialUnitName = 'mas0001'
		cdrUnit = CreateInitialArmyUnit(strArmy, initialUnitName)
        GetArmyBrain(strArmy).PreBuilt = false
        ForkThread(CommanderWarpDelay, cdrUnit, 3)
    end
    return tblGroup , cdrUnit
end
function CommanderWarpDelay(cdrUnit, delay)
    cdrUnit:SetBlockCommandQueue(true)
    WaitSeconds(delay)
    cdrUnit:PlayCommanderWarpInEffect()
end