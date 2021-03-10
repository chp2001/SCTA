local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAINavalBuilder',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'SCTAAi Factory ScoutShip',
        PlatoonTemplate = 'T1ScoutShipSCTA',
        Priority = 110,
        BuilderConditions = {
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Naval Engineer',
        PlatoonTemplate = 'T1EngineerSCTANaval',
        Priority = 100, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.ENGINEER - categories.COMMAND } }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Frigate Naval',
        PlatoonTemplate = 'T1FrigateSCTA',
        Priority = 90,
        BuilderConditions = {
        },
        BuilderType = 'All',
    },
}
