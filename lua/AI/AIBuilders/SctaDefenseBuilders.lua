local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAIDefenseBuilder',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTAMissileTower',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 50,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.33, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AADefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTALaserTower',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 50,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {480} }, -- Don't make tanks if we have lots of them.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.LASER * categories.LEVEL1 } }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.7}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1GroundDefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAMissileDefense',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 70,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ANTIMISSILE} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.7}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2MissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'SCTALaser2Tower',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 60,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.LASER * categories.LEVEL2 } }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.75}}, 
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2GroundDefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTALaser3Tower',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 60,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.LASER * categories.LEVEL2 } }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.4, 0.25}}, 
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T3GroundDefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAMissileTower Emergency',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 60,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {480} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.5, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AADefense',
                }
            }
        }
    },
}