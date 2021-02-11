
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAIFactoryBuilders',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTAAI T1Engineer AirFac2',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 95,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {360} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1,  categories.FACTORY * categories.AIR} },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                    'T1Radar',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer LandFac',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 95,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FACTORY * categories.LEVEL2 * categories.LAND } }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 12, categories.FACTORY * categories.LEVEL1} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.3, 0.5}}, -- Stop after 10 facs have been built.
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer LandFac2',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 90,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FACTORY * categories.LEVEL2 * categories.LAND } }, -- Stop after 10 facs have been built.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 12, categories.FACTORY * categories.LEVEL1} }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconStorageRatio', { 0.3, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory2',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer AirFac',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 90,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 6,  categories.FACTORY * categories.LEVEL1 } }, -- Don't build air fac immediately.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4,  categories.FACTORY * categories.AIR} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1,  categories.FACTORY * categories.AIR * categories.LEVEL2  } }, -- Stop after 5 facs have been built.
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.8}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AirFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2LAND Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA12',
        Priority = 120,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {700} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.FACTORY * categories.LEVEL2 * categories.LAND } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 1,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2LAND2 Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA12',
        Priority = 115,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {750} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.5}},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.FACTORY * categories.LEVEL2 * categories.LAND } }, -- Stop after 10 facs have been built.
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2LandFactory2',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T3LAND Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 130,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1500} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.5}},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.FACTORY * categories.LEVEL3 * categories.LAND} }, -- Stop after 10 facs have been built.
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T3LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2AirFactory',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 105,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {900} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.5}},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.LEVEL2 * categories.AIR } }, -- Stop after 10 facs have been built.
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T2AirFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI Gantry Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 135,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1500} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.5}},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.GATE} }, -- Stop after 10 facs have been built.
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T3QuantumGate',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI LandFac Emergency',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 500,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {180} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.FACTORY * categories.LEVEL2 * categories.LAND } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconStorageRatio', { 0.5, 0.5}},
            { MIBC, 'LessThanGameTime', {1200} },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI LandFac2 Emergency',
        PlatoonTemplate = 'EngineerBuilderSCTA12',
        Priority = 600,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {750} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.LEVEL3 * categories.LAND } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconStorageRatio', { 0.5, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI LandFac3 Emergency',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 750,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1500} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.5, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T3LandFactory',
                }
            }
        }
    },
}